module Lib.CoreEngine.GameLayer.Model exposing (..)

import Array
import Array.Extra
import Base exposing (GlobalData, Msg(..))
import Lib.Coordinate.Coordinates exposing (fromMouseToReal, posToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Camera exposing (getNewCamera)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, GameComponent, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive, sendManyGameComponentMsg, simpleUpdateAllGameComponent, splitPlayerObjs, updateOneGameComponent)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.CoreEngine.Physics.InterCollision exposing (gonnaInterColllide)
import Lib.CoreEngine.Physics.NaiveCollision exposing (judgeInCamera)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove, gonnaSolidCollide, movePointPlain)
import Lib.Layer.Base exposing (LayerMsg, LayerTarget)
import Lib.Tools.Array exposing (locate)
import Math.Vector2 exposing (vec2)


initModel : Int -> LayerMsg -> GameGlobalData -> Model
initModel _ _ _ =
    { player = Player.gameComponent, actors = Array.fromList [ Goomba.gameComponent ] }


deleteObjects : GameGlobalData -> Array.Array GameComponent -> Array.Array GameComponent
deleteObjects ggd gcs =
    Array.filter
        (\x ->
            case x.data.status of
                Alive ->
                    True

                Dead _ ->
                    if judgeInCamera x ggd then
                        True

                    else
                        False
        )
        gcs


playerMove : Data -> Data
playerMove player =
    let
        pv =
            player.velocity

        ( npx, npy ) =
            pv

        pvv =
            Math.Vector2.vec2 npx npy

        newpos =
            movePointPlain pvv player.position

        newplayer =
            { player | position = newpos }
    in
    newplayer


clearWrongVelocity : GameGlobalData -> Array.Array GameComponent -> Array.Array GameComponent
clearWrongVelocity ggd gcs =
    Array.map
        (\gc ->
            let
                ( pvx, pvy ) =
                    gc.data.velocity

                player =
                    gc.data

                ( npvx, npvy ) =
                    if pvy < 0 && not (canMove player ggd (vec2 0 -1)) then
                        ( pvx, 0 )

                    else if pvy > 0 && not (canMove player ggd (vec2 0 1)) then
                        ( pvx, 0 )

                    else
                        ( pvx, pvy )

                fv =
                    if npvx < 0 && not (canMove player ggd (vec2 -1 0)) then
                        ( 0, npvy )

                    else if npvx > 0 && not (canMove player ggd (vec2 1 0)) then
                        ( 0, npvy )

                    else
                        ( npvx, npvy )

                newdata =
                    { player | velocity = fv }
            in
            if isAlive gc.data then
                { gc | data = newdata }

            else
                gc
        )
        gcs


solidCollision : Msg -> Int -> GameGlobalData -> GlobalData -> Array.Array GameComponent -> ( Array.Array GameComponent, List GameComponentMsgType, GameGlobalData )
solidCollision msg t ggd gd gcs =
    Array.foldl
        (\g ( ncs, nms, lggd ) ->
            let
                checksolid =
                    gonnaSolidCollide g.data ggd

                ( newsol, newmsg, newggd ) =
                    if List.isEmpty checksolid || not (isAlive g.data) then
                        -- Update Position
                        ( { g | data = playerMove g.data }, [], lggd )

                    else
                        -- Deal with position inside component
                        let
                            ( newd, kdsl, nndd ) =
                                updateOneGameComponent msg (GameSolidCollisionMsg checksolid) lggd gd t g
                        in
                        ( newd, kdsl, nndd )
            in
            ( Array.push newsol ncs, nms ++ newmsg, newggd )
        )
        ( Array.empty, [], ggd )
        gcs


interCollision : Msg -> Int -> GameGlobalData -> GlobalData -> Array.Array GameComponent -> ( Array.Array GameComponent, List GameComponentMsgType, GameGlobalData )
interCollision _ t ggd gd gcs =
    let
        elenum =
            Array.length gcs

        blc : Array.Array (List GameComponentTMsg)
        blc =
            Array.repeat elenum []

        msggcs =
            Array.Extra.zip gcs blc

        is =
            List.range 0 (elenum - 1)

        newc =
            List.foldl
                (\i ms ->
                    let
                        js =
                            List.range (i + 1) (elenum - 1)
                    in
                    List.foldl
                        (\j mms ->
                            let
                                gci =
                                    Array.get i mms

                                gcj =
                                    Array.get j mms
                            in
                            case ( gci, gcj ) of
                                ( Just ( gc1, gc1msg ), Just ( gc2, gc2msg ) ) ->
                                    if isAlive gc1.data && isAlive gc2.data then
                                        let
                                            ( am1, am2 ) =
                                                gonnaInterColllide gc1 gc2

                                            ( ud1, ud2 ) =
                                                case ( am1, am2 ) of
                                                    ( NullGameComponentMsg, NullGameComponentMsg ) ->
                                                        ( ( gc1, gc1msg ), ( gc2, gc2msg ) )

                                                    _ ->
                                                        ( ( gc1, am1 :: gc1msg ), ( gc2, am2 :: gc2msg ) )
                                        in
                                        mms
                                            |> Array.set i ud1
                                            |> Array.set j ud2

                                    else
                                        mms

                                _ ->
                                    mms
                        )
                        ms
                        js
                )
                msggcs
                is

        ( appliedgc, appliedmsg, appliedggc ) =
            Array.foldl
                (\( gc, gcm ) ( bgc, bgmsg, cggd ) ->
                    let
                        ( newgc, newmg, newggd ) =
                            List.foldl
                                (\cmsg ( ccc, mmm, ggg ) ->
                                    let
                                        ( updgc, updmsg, updggg ) =
                                            updateOneGameComponent UnknownMsg cmsg ggg gd t ccc
                                    in
                                    ( updgc, updmsg ++ mmm, updggg )
                                )
                                ( gc, [], cggd )
                                gcm
                    in
                    ( Array.push newgc bgc, bgmsg ++ newmg, newggd )
                )
                ( Array.empty, [], ggd )
                newc
    in
    ( appliedgc, appliedmsg, appliedggc )


searchNameGC : String -> Array.Array GameComponent -> List Int
searchNameGC s gcs =
    locate (\x -> x.name == s) gcs


searchUIDGC : Int -> Array.Array GameComponent -> Int
searchUIDGC s gcs =
    let
        res =
            locate (\x -> x.data.uid == s) gcs
    in
    case res of
        [ x ] ->
            x

        _ ->
            -1


kineticCalc : Int -> ( Float, Float ) -> Float
kineticCalc mass ( vx, vy ) =
    toFloat mass * (vx * vx + vy * vy) / 10000


calcRPer : ( Float, Float ) -> ( Float, Float ) -> GlobalData -> Float
calcRPer ( px, py ) ( mx, my ) gd =
    let
        dis =
            sqrt ((mx - px) ^ 2 + (my - py) ^ 2)

        sl =
            sqrt (toFloat gd.realHeight ^ 2 + toFloat gd.realWidth ^ 2)
    in
    dis / sl * 2


getDSEnergy : ( Float, Float ) -> ( Float, Float ) -> GlobalData -> GameGlobalData -> ( Float, GameGlobalData )
getDSEnergy p m gd ggd =
    let
        curenergy =
            ggd.energy

        pc =
            calcRPer p m gd

        gpc =
            curenergy * pc
    in
    if pc < 0.2 then
        ( 0, ggd )

    else if pc >= 1 then
        ( curenergy, { ggd | energy = 0 } )

    else
        ( gpc, { ggd | energy = curenergy - gpc } )


updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) ggd =
    case msg of
        Tick _ ->
            -- Tick, calculate collision
            let
                allobjs =
                    Array.push model.player model.actors

                removedobjs =
                    deleteObjects ggd allobjs

                ( updatedobjs, updatedmsg, updatedggd ) =
                    simpleUpdateAllGameComponent msg NullGameComponentMsg ggd gd t removedobjs

                clearedobjs =
                    clearWrongVelocity updatedggd updatedobjs

                -- Obj vs Solid
                ( aftersolidobjs, solidmsg, aftersolidggd ) =
                    solidCollision msg t updatedggd gd clearedobjs

                -- Obj vs Obj
                ( afterinterobjs, intermsg, afterinterggd ) =
                    interCollision msg t aftersolidggd gd aftersolidobjs

                -- No recursive support
                allmsg =
                    updatedmsg ++ solidmsg ++ intermsg

                allparentmsg =
                    List.filter
                        (\x ->
                            case x of
                                GameParentMsg _ ->
                                    True

                                _ ->
                                    False
                        )
                        allmsg

                -- TODO: handle parentmsg
                ( finalobjs, finalggd ) =
                    List.foldl
                        (\m ( ao, ai ) ->
                            case m of
                                GameActorNameMsg s mm ->
                                    let
                                        rid =
                                            searchNameGC s ao

                                        ( res, _, newgg ) =
                                            sendManyGameComponentMsg UnknownMsg mm ai gd rid t ao
                                    in
                                    ( res, newgg )

                                GameActorUidMsg s mm ->
                                    let
                                        rid =
                                            searchUIDGC s ao

                                        ( res, _, newgg ) =
                                            sendManyGameComponentMsg UnknownMsg mm ai gd [ rid ] t ao
                                    in
                                    ( res, newgg )

                                _ ->
                                    ( ao, ai )
                        )
                        ( afterinterobjs, afterinterggd )
                        allmsg

                ( newplayer, newactors ) =
                    splitPlayerObjs finalobjs model.player

                newcamera =
                    getNewCamera finalggd newplayer.data
            in
            ( ( { model | player = newplayer, actors = newactors }, { finalggd | camera = newcamera }, [] ), gd )

        KeyDown 67 ->
            if ggd.selectobj > 0 then
                if ggd.selectobj == model.player.data.uid then
                    let
                        k =
                            kineticCalc model.player.data.mass model.player.data.velocity

                        ( newplayer, _, newggd ) =
                            if k > 300 then
                                updateOneGameComponent UnknownMsg GameClearVelocity ggd gd t model.player

                            else
                                ( model.player, [], ggd )

                        tcggd =
                            if k > 300 then
                                { newggd | energy = newggd.energy + k }

                            else
                                newggd
                    in
                    ( ( { model | player = newplayer }, tcggd, [] ), gd )

                else
                    let
                        tn =
                            searchUIDGC ggd.selectobj model.actors

                        tac =
                            Array.get tn model.actors
                    in
                    case tac of
                        Just thisactor ->
                            let
                                k =
                                    kineticCalc thisactor.data.mass thisactor.data.velocity

                                ( newactor, _, newggd ) =
                                    if k > 300 then
                                        updateOneGameComponent UnknownMsg GameClearVelocity ggd gd t thisactor

                                    else
                                        ( thisactor, [], ggd )

                                onew =
                                    if k > 300 then
                                        { newggd | energy = newggd.energy + k }

                                    else
                                        newggd

                                newactors =
                                    Array.set tn newactor model.actors
                            in
                            ( ( { model | actors = newactors }, onew, [] ), gd )

                        Nothing ->
                            ( ( model, ggd, [] ), gd )

            else
                ( ( model, ggd, [] ), gd )

        KeyDown _ ->
            let
                ( newplayer, _, newggd ) =
                    updateOneGameComponent msg NullGameComponentMsg ggd gd t model.player
            in
            ( ( { model | player = newplayer }, newggd, [] ), gd )

        KeyUp _ ->
            let
                ( newplayer, _, newggd ) =
                    updateOneGameComponent msg NullGameComponentMsg ggd gd t model.player
            in
            ( ( { model | player = newplayer }, newggd, [] ), gd )

        MouseDown 2 mp ->
            if ggd.selectobj > 0 then
                if ggd.selectobj == model.player.data.uid then
                    let
                        ( px, py ) =
                            posToReal gd (getPositionUnderCamera model.player.data.position ggd)

                        ( mx, my ) =
                            fromMouseToReal gd mp

                        pp =
                            ( px, py )

                        mm =
                            ( mx, my )

                        ( xsable, updss ) =
                            getDSEnergy pp mm gd ggd

                        newplayer =
                            if xsable > 0 then
                                let
                                    ( up, _, _ ) =
                                        updateOneGameComponent UnknownMsg (GameUseEnergy ( mx - px, my - py ) xsable) ggd gd t model.player
                                in
                                up

                            else
                                model.player
                    in
                    ( ( { model | player = newplayer }, updss, [] ), gd )

                else
                    let
                        tn =
                            searchUIDGC ggd.selectobj model.actors

                        tac =
                            Array.get tn model.actors
                    in
                    case tac of
                        Just thisactor ->
                            let
                                ( px, py ) =
                                    posToReal gd (getPositionUnderCamera thisactor.data.position ggd)

                                ( mx, my ) =
                                    fromMouseToReal gd mp

                                pp =
                                    ( px, py )

                                mm =
                                    ( mx, my )

                                ( xsable, updss ) =
                                    getDSEnergy pp mm gd ggd

                                newplayer =
                                    if xsable > 0 then
                                        let
                                            ( up, _, _ ) =
                                                updateOneGameComponent UnknownMsg (GameUseEnergy ( mx - px, my - py ) xsable) ggd gd t thisactor
                                        in
                                        up

                                    else
                                        thisactor

                                newactors =
                                    Array.set tn newplayer model.actors
                            in
                            ( ( { model | actors = newactors }, updss, [] ), gd )

                        Nothing ->
                            ( ( model, ggd, [] ), gd )

            else
                ( ( model, ggd, [] ), gd )

        MouseDown 0 _ ->
            let
                allobjs =
                    Array.push model.player model.actors

                ( newobjs, _, newggd ) =
                    simpleUpdateAllGameComponent msg NullGameComponentMsg ggd gd t allobjs

                ( newplayer, newactors ) =
                    splitPlayerObjs newobjs model.player
            in
            ( ( { model | actors = newactors, player = newplayer }, newggd, [] ), gd )

        _ ->
            ( ( model, ggd, [] ), gd )
