module Lib.CoreEngine.GameLayer.Model exposing
    ( initModel
    , updateModel
    )

{-| This is the doc for this module

@docs initModel

@docs updateModel

-}

import Array
import Array.Extra
import Base exposing (GlobalData, Msg(..))
import Lib.Coordinate.Coordinates exposing (fromMouseToReal, posToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Camera exposing (getNewCamera)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, GameComponent, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (getGameComponentCenter, initGameComponent, isAlive, sendManyGameComponentMsg, simpleUpdateAllGameComponent, splitPlayerObjs, updateOneGameComponent, updateSingleGameComponentByName)
import Lib.CoreEngine.GameComponent.GenUID exposing (genUID)
import Lib.CoreEngine.GameComponents.Bullet.Export as Bullet
import Lib.CoreEngine.GameComponents.Fireball.Export as Fireball
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Base exposing (BoundKey, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Player.FSM exposing (queryIsState)
import Lib.CoreEngine.GameLayer.Common exposing (Model, addenergy, getDSEnergy, kineticCalc, searchNameGC, searchUIDGC)
import Lib.CoreEngine.Physics.InterCollision exposing (gonnaInterColllide)
import Lib.CoreEngine.Physics.NaiveCollision exposing (judgeInCamera)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove, gonnaSolidCollide, movePointPlain)
import Lib.DefinedTypes.Parser exposing (dgetPlayer, dsetPlayer)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (EngineT)
import Math.Vector2 exposing (vec2)


{-| initModel
-}
initModel : Int -> LayerMsg -> GameGlobalData -> Model
initModel _ lm _ =
    case lm of
        LayerInitGameLayer info ->
            { player = info.player, actors = info.actors, chartlets = info.chartlets, lastuseEnergyTime = 0, ignoreInput = False }

        _ ->
            { player = Player.gameComponent, actors = Array.fromList [ Goomba.gameComponent ], chartlets = [], lastuseEnergyTime = 0, ignoreInput = False }


{-| deleteObjects
-}
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


releaseObjects : GameGlobalData -> Array.Array GameComponent -> GameGlobalData
releaseObjects ggd gcs =
    if
        Array.Extra.any
            (\x ->
                case x.data.status of
                    Alive ->
                        False

                    Dead _ ->
                        if x.data.uid == ggd.selectobj then
                            True

                        else
                            False
            )
            gcs
    then
        { ggd | selectobj = -1 }

    else
        ggd


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


judgePlayerOK : GameGlobalData -> GameComponent -> Bool
judgePlayerOK ggd player =
    case player.data.status of
        Alive ->
            True

        Dead _ ->
            if judgeInCamera player ggd then
                True

            else
                False


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
            in
            if isAlive gc.data then
                { gc | data = { player | velocity = fv } }

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


interCollisionPreUpdate : Array.Array GameComponent -> Array.Array ( GameComponent, List GameComponentTMsg )
interCollisionPreUpdate gcs =
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
    in
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


interCollision : Msg -> Int -> GameGlobalData -> GlobalData -> Array.Array GameComponent -> ( Array.Array GameComponent, List GameComponentMsgType, GameGlobalData )
interCollision _ t ggd gd gcs =
    let
        newc =
            interCollisionPreUpdate gcs

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


clearPlayerStatus : GameComponent -> GameComponent
clearPlayerStatus gc =
    let
        player =
            gc.data.extra

        playerextra =
            dgetPlayer player "model"

        nokey =
            BoundKey 0 0 0 0 0

        newp =
            { playerextra | originKeys = nokey }

        newplayer =
            dsetPlayer "model" newp player

        odata =
            gc.data

        newdata =
            { odata | extra = newplayer }
    in
    { gc | data = newdata }


dealParentMsgp1 : GameComponentTMsg -> GlobalData -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
dealParentMsgp1 gct gd ( model, t ) ggd =
    case gct of
        GameStringMsg "ignoreinput" ->
            let
                player =
                    model.player.data.extra

                playerextra =
                    dgetPlayer player "model"

                nokey =
                    BoundKey 0 0 0 0 0

                newp =
                    { playerextra | originKeys = nokey }

                newplayer =
                    dsetPlayer "model" newp player

                odata =
                    model.player.data

                ( ovx, ovy ) =
                    odata.velocity

                newdata =
                    if ovx + ovy > 400 then
                        { odata | extra = newplayer, velocity = ( ovx / 2, ovy / 2 ) }

                    else
                        { odata | extra = newplayer }

                opp =
                    model.player

                nnplayer =
                    { opp | data = newdata }
            in
            ( ( { model | ignoreInput = True, player = nnplayer }, ggd, [] ), gd )

        GameStringMsg "reactinput" ->
            ( ( { model | ignoreInput = False }, ggd, [] ), gd )

        GameStringMsg "stopgamelayer" ->
            ( ( model, { ggd | ingamepause = True }, [] ), gd )

        GameStringMsg "startgamelayer" ->
            ( ( model, { ggd | ingamepause = False }, [] ), gd )

        _ ->
            ( ( model, ggd, [] ), gd )


{-| dealParentMsg
-}
dealParentMsg : GameComponentTMsg -> GlobalData -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
dealParentMsg gct gd ( model, t ) ggd =
    case gct of
        GameExitScene s pls spstate ->
            ( ( model, { ggd | ingamepause = True }, [ ( LayerName "Frontground", LayerExitMsg (EngineT ggd.energy pls ggd.collectedMonsters spstate) s 50 ) ] ), gd )

        GameStringMsg "restart" ->
            ( ( model, { ggd | ingamepause = True }, [ ( LayerName "Frontground", LayerRestartMsg 10 ) ] ), gd )

        GameLStringMsg ("collectmonster" :: pic :: _) ->
            let
                newggd =
                    { ggd | collectedMonsters = ggd.collectedMonsters ++ [ pic ] }

                oldls =
                    gd.localstorage

                newls =
                    { oldls | collected = newggd.collectedMonsters }
            in
            ( ( model, newggd, [] ), { gd | localstorage = newls } )

        GameInfoPositionMsg "save" p ->
            ( ( model, ggd, [ ( LayerName "Frontground", LayerInfoPositionMsg "save" p ) ] ), gd )

        GameGoombaInit info ->
            -- Create a goomba
            let
                newinfo =
                    { info | uid = genUID model }
            in
            ( ( { model | actors = Array.push (initGameComponent t (GameGoombaInit newinfo) Goomba.gameComponent) model.actors }, ggd, [] ), gd )

        GameBulletInit info ->
            -- Create a goomba
            let
                newinfo =
                    { info | uid = genUID model }
            in
            ( ( { model | actors = Array.push (initGameComponent t (GameBulletInit newinfo) Bullet.gameComponent) model.actors }, ggd, [] ), gd )

        GameFireballInit info ->
            -- Create a goomba
            let
                newinfo =
                    { info | uid = genUID model }
            in
            ( ( { model | actors = Array.push (initGameComponent t (GameFireballInit newinfo) Fireball.gameComponent) model.actors }, ggd, [] ), gd )

        GameStringIntMsg "addenergy" i ->
            let
                newe =
                    if ggd.energy + toFloat i <= 0 then
                        0

                    else
                        ggd.energy + toFloat i
            in
            ( ( model, { ggd | energy = newe }, [] ), gd )

        _ ->
            dealParentMsgp1 gct gd ( model, t ) ggd



-- {-| dealAllParentMsg
-- -}
-- dealAllParentMsg : List GameComponentTMsg -> GlobalData -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
-- dealAllParentMsg allparentmsg gd ( model, t ) ggd =
--     List.foldl
--         (\tm ( ( cm, cggd, cam ), cgd ) ->
--             let
--                 ( ( nnm, nnggd, nndmd ), nngd ) =
--                     dealParentMsg tm cgd ( cm, t ) cggd
--             in
--             ( ( nnm, nnggd, cam ++ nndmd ), nngd )
--         )
--         ( ( model, ggd, [] ), gd )
--         allparentmsg


updateModelTick : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModelTick msg gd _ ( model, t ) ggd =
    let
        allobjs =
            Array.push model.player model.actors

        clearSel =
            releaseObjects ggd allobjs

        removedobjs =
            deleteObjects clearSel allobjs

        ( updatedobjs, updatedmsg, updatedggd ) =
            simpleUpdateAllGameComponent msg NullGameComponentMsg clearSel gd t removedobjs

        clearedobjs =
            clearWrongVelocity updatedggd updatedobjs

        -- Obj vs Solid
        ( aftersolidobjs, solidmsg, aftersolidggd ) =
            solidCollision msg t updatedggd gd clearedobjs

        -- Obj vs Obj
        ( afterinterobjs, intermsg, afterinterggd ) =
            interCollision msg t aftersolidggd gd aftersolidobjs

        restartmsg =
            if judgePlayerOK ggd model.player then
                []

            else
                [ GameStringMsg "restart" ]

        -- No recursive support
        allmsg =
            updatedmsg ++ solidmsg ++ intermsg

        allparentmsg =
            List.filterMap
                (\x ->
                    case x of
                        GameParentMsg tmsg ->
                            Just tmsg

                        _ ->
                            Nothing
                )
                (allmsg ++ finalmsg)
                ++ restartmsg

        -- TODO: handle parentmsg
        ( finalobjs, finalmsg, finalggd ) =
            List.foldl
                (\m ( ao, alllm, ai ) ->
                    case m of
                        GameActorNameMsg s mm ->
                            let
                                rid =
                                    searchNameGC s ao

                                ( res, nmsg, newgg ) =
                                    sendManyGameComponentMsg UnknownMsg mm ai gd rid t ao
                            in
                            ( res, alllm ++ nmsg, newgg )

                        GameActorUidMsg s mm ->
                            let
                                rid =
                                    searchUIDGC s ao

                                ( res, nmsg, newgg ) =
                                    sendManyGameComponentMsg UnknownMsg mm ai gd [ rid ] t ao
                            in
                            ( res, alllm ++ nmsg, newgg )

                        _ ->
                            ( ao, alllm, ai )
                )
                ( afterinterobjs, [], afterinterggd )
                allmsg

        ( newplayer, newactors ) =
            splitPlayerObjs finalobjs model.player

        newcamera =
            getNewCamera finalggd newplayer.data

        newmodel =
            { model | player = newplayer, actors = newactors }

        newggd =
            { finalggd | camera = newcamera }

        newiter =
            if judgePlayerOK ggd model.player then
                ( ( newmodel, newggd, [] ), gd )

            else
                ( ( model, ggd, [] ), gd )
    in
    List.foldl
        (\tm ( ( cm, cggd, cam ), cgd ) ->
            let
                ( ( nnm, nnggd, nndmd ), nngd ) =
                    dealParentMsg tm cgd ( cm, t ) cggd
            in
            ( ( nnm, nnggd, cam ++ nndmd ), nngd )
        )
        newiter
        allparentmsg


updateModelKeydown : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModelKeydown msg gd _ ( model, t ) ggd =
    case msg of
        KeyDown 87 ->
            if model.ignoreInput then
                ( ( model, ggd, [] ), gd )

            else if ggd.selectobj > 0 then
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
                                { newggd | energy = addenergy ggd.energy k }

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
                                        { newggd | energy = addenergy ggd.energy k }

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

        KeyDown 82 ->
            -- Restart
            if model.ignoreInput then
                ( ( model, ggd, [] ), gd )

            else
                ( ( model, { ggd | ingamepause = True }, [ ( LayerName "Frontground", LayerRestartMsg 10 ) ] ), gd )

        KeyDown _ ->
            if model.ignoreInput then
                ( ( model, ggd, [] ), gd )

            else
                let
                    ( newplayer, _, newggd ) =
                        updateOneGameComponent msg NullGameComponentMsg ggd gd t model.player
                in
                ( ( { model | player = newplayer }, newggd, [] ), gd )

        _ ->
            ( ( model, ggd, [] ), gd )


playerupdatemouse : ( Float, Float ) -> GlobalData -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
playerupdatemouse mp gd ( model, t ) ggd =
    let
        pls =
            dgetPlayer model.player.data.extra "model"

        isinair =
            queryIsState
                pls
                "inair"
    in
    if isinair then
        ( ( model, ggd, [] ), gd )

    else
        let
            ( px, py ) =
                posToReal gd (getPositionUnderCamera (getGameComponentCenter model.player) ggd)

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
        ( ( { model | player = newplayer, lastuseEnergyTime = t }, updss, [] ), gd )


actorupdatemouse : ( Float, Float ) -> GlobalData -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
actorupdatemouse mp gd ( model, t ) ggd =
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
                    posToReal gd (getPositionUnderCamera (getGameComponentCenter thisactor) ggd)

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
            ( ( { model | actors = newactors, lastuseEnergyTime = t }, updss, [] ), gd )

        Nothing ->
            ( ( model, ggd, [] ), gd )


updateModelMouseDown : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModelMouseDown msg gd _ ( model, t ) ggd =
    case msg of
        MouseDown 2 mp ->
            if model.ignoreInput then
                let
                    ( newactors, _, newggd ) =
                        updateSingleGameComponentByName msg NullGameComponentMsg ggd gd t "CutScene" model.actors
                in
                ( ( { model | actors = newactors }, newggd, [] ), gd )

            else if t - model.lastuseEnergyTime < 15 then
                ( ( model, ggd, [] ), gd )

            else if ggd.selectobj > 0 then
                if ggd.selectobj == model.player.data.uid then
                    playerupdatemouse mp gd ( model, t ) ggd

                else
                    actorupdatemouse mp gd ( model, t ) ggd

            else
                ( ( model, ggd, [] ), gd )

        MouseDown 0 _ ->
            if model.ignoreInput then
                let
                    ( newactors, _, newggd ) =
                        updateSingleGameComponentByName msg NullGameComponentMsg ggd gd t "CutScene" model.actors
                in
                ( ( { model | actors = newactors }, newggd, [] ), gd )

            else
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


{-| updateModel
-}
updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd lm ( model, t ) ggd =
    case lm of
        LayerStringMsg "stopinput" ->
            ( ( { model | ignoreInput = True }, ggd, [] ), gd )

        LayerStringMsg "startinput" ->
            ( ( { model | ignoreInput = False }, ggd, [] ), gd )

        LayerStringMsg "stoplayer" ->
            ( ( model, { ggd | ingamepause = True }, [] ), gd )

        LayerStringMsg "startlayer" ->
            ( ( model, { ggd | ingamepause = False }, [] ), gd )

        LayerStringMsg "skipcutscene" ->
            let
                alc =
                    model.actors

                ( newactors, _, newggd ) =
                    updateSingleGameComponentByName UnknownMsg (GameStringMsg "skip") ggd gd t "CutScene" alc
            in
            ( ( { model | actors = newactors, ignoreInput = False }, newggd, [] ), gd )

        LayerStringMsg "clearPlayerInput" ->
            let
                player =
                    model.player
            in
            ( ( { model | player = clearPlayerStatus player }, ggd, [] ), gd )

        _ ->
            if ggd.ingamepause then
                ( ( model, ggd, [] ), gd )

            else
                case msg of
                    Tick _ ->
                        updateModelTick msg gd lm ( model, t ) ggd

                    KeyDown _ ->
                        updateModelKeydown msg gd lm ( model, t ) ggd

                    MouseDown _ _ ->
                        updateModelMouseDown msg gd lm ( model, t ) ggd

                    KeyUp _ ->
                        if model.ignoreInput then
                            ( ( model, ggd, [] ), gd )

                        else
                            let
                                ( newplayer, _, newggd ) =
                                    updateOneGameComponent msg NullGameComponentMsg ggd gd t model.player
                            in
                            ( ( { model | player = newplayer }, newggd, [] ), gd )

                    _ ->
                        ( ( model, ggd, [] ), gd )
