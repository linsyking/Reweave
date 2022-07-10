module Lib.CoreEngine.GameLayer.Model exposing (..)

import Array
import Array.Extra
import Base exposing (GlobalData, Msg(..))
import Lib.Coordinate.Coordinates exposing (fromMouseToReal, posToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Camera exposing (getNewCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive, sendManyGameComponentMsg, simpleUpdateAllGameComponent, splitPlayerObjs, updateOneGameComponent)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.CoreEngine.Physics.InterCollision exposing (gonnaInterColllide)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos, judgeInCamera)
import Lib.CoreEngine.Physics.SolidCollision exposing (gonnaSolidCollide)
import Lib.Layer.Base exposing (LayerMsg, LayerTarget)
import Lib.Tools.Array exposing (locate)
import Math.Vector2 exposing (vec2)


initModel : Int -> GameGlobalData -> Model
initModel _ _ =
    { player = Player.gameComponent, actors = Array.empty }


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


solidCollision : Msg -> Int -> GameGlobalData -> GlobalData -> Array.Array GameComponent -> Array.Array GameComponent -> ( Array.Array GameComponent, List GameComponentMsgType, GameGlobalData )
solidCollision msg t ggd gd oldgcs updgcs =
    Array.foldl
        (\( u, o ) ( ncs, nms, lggd ) ->
            let
                checksolid =
                    gonnaSolidCollide u.data ggd

                ( newsol, newmsg, newggd ) =
                    if List.isEmpty checksolid || not (isAlive o) then
                        ( u, [], lggd )

                    else
                        updateOneGameComponent msg (GameSolidCollisionMsg checksolid) lggd gd t o
            in
            ( Array.push newsol ncs, nms ++ newmsg, newggd )
        )
        ( Array.empty, [], ggd )
        (Array.Extra.zip updgcs oldgcs)


interCollision : Msg -> Int -> GameGlobalData -> GlobalData -> Array.Array GameComponent -> ( Array.Array GameComponent, List GameComponentMsgType, GameGlobalData )
interCollision msg t ggd gd gcs =
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
                                    let
                                        ( am1, am2 ) =
                                            gonnaInterColllide gc1 gc2

                                        ud1 =
                                            ( gc1, am1 :: gc1msg )

                                        ud2 =
                                            ( gc2, am2 :: gc2msg )
                                    in
                                    mms
                                        |> Array.set i ud1
                                        |> Array.set j ud2

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
                                            updateOneGameComponent msg cmsg ggg gd t ccc
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


changeCVel : GameComponent -> ( Float, Float ) -> Float -> GameComponent
changeCVel c ( px, py ) k =
    let
        cm =
            c.data.mass

        punit =
            Math.Vector2.normalize (vec2 px py)

        nm =
            Math.Vector2.scale (sqrt (k / toFloat cm) * 300) punit

        newvx =
            Math.Vector2.getX nm

        newvy =
            Math.Vector2.getY nm

        odata =
            c.data

        ( ovx, ovy ) =
            odata.velocity

        das =
            Debug.log "newv" ( newvx, newvy )

        newdata =
            { odata | velocity = ( newvx + ovx, newvy + ovy ) }
    in
    { c | data = newdata }


kineticCalc : Int -> ( Float, Float ) -> Float
kineticCalc mass ( vx, vy ) =
    toFloat mass * (vx * vx + vy * vy) / 10000


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

                -- Obj vs Solid
                ( aftersolidobjs, solidmsg, aftersolidggd ) =
                    solidCollision msg t updatedggd gd removedobjs updatedobjs

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
                                            sendManyGameComponentMsg msg mm ai gd rid t ao
                                    in
                                    ( res, newgg )

                                GameActorUidMsg s mm ->
                                    let
                                        rid =
                                            searchUIDGC s ao

                                        ( res, _, newgg ) =
                                            sendManyGameComponentMsg msg mm ai gd [ rid ] t ao
                                    in
                                    ( res, newgg )

                                _ ->
                                    ( ao, ai )
                        )
                        ( afterinterobjs, afterinterggd )
                        allmsg

                ( newplayer, newactors ) =
                    splitPlayerObjs finalobjs model.player

                ( omx, omy ) =
                    finalggd.mapsize

                newcameraPosition =
                    getNewCamera finalggd.cameraPosition (getBoxPos newplayer.data.position newplayer.data.simplecheck) ( omx * brickSize, omy * brickSize )
            in
            ( ( { model | player = newplayer, actors = newactors }, { finalggd | cameraPosition = newcameraPosition }, [] ), gd )

        KeyDown 67 ->
            if ggd.selectobj > 0 then
                if ggd.selectobj == model.player.data.uid then
                    let
                        k =
                            kineticCalc model.player.data.mass model.player.data.velocity

                        ( newplayer, _, newggd ) =
                            updateOneGameComponent UnknownMsg ClearVelocity ggd gd t model.player
                    in
                    ( ( { model | player = newplayer }, { newggd | energy = newggd.energy + k }, [] ), gd )

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
                                    updateOneGameComponent UnknownMsg ClearVelocity ggd gd t thisactor

                                newactors =
                                    Array.set tn newactor model.actors
                            in
                            ( ( { model | actors = newactors }, { newggd | energy = newggd.energy + k }, [] ), gd )

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
                        ( rpx, rpy ) =
                            posToReal gd model.player.data.position

                        ( mpx, mpy ) =
                            fromMouseToReal gd mp

                        pov =
                            ( mpx - rpx, rpy - mpy )

                        newplayer =
                            changeCVel model.player pov ggd.energy
                    in
                    ( ( { model | player = newplayer }, { ggd | energy = 0 }, [] ), gd )

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
                                ( rpx, rpy ) =
                                    posToReal gd thisactor.data.position

                                ( mpx, mpy ) =
                                    fromMouseToReal gd mp

                                pov =
                                    ( mpx - rpx, rpy - mpy )

                                newactor =
                                    changeCVel thisactor pov ggd.energy

                                newactors =
                                    Array.set tn newactor model.actors
                            in
                            ( ( { model | actors = newactors }, { ggd | energy = 0 }, [] ), gd )

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