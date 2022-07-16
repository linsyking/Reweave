module Lib.CoreEngine.GameComponents.Player.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive)
import Lib.CoreEngine.GameComponents.Player.Base exposing (changebk, nullModel)
import Lib.CoreEngine.GameComponents.Player.InputFilter exposing (afterMove, preCheck)
import Lib.CoreEngine.GameComponents.Player.InputHandler exposing (changePlayerVelocity)
import Lib.CoreEngine.GameComponents.Player.Movement exposing (solidCollisionMove)
import Lib.CoreEngine.GameComponents.Player.StatesControl exposing (stateControl)
import Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)
import Lib.DefinedTypes.Parser exposing (dgetPlayer, dsetPlayer)


initData : Data
initData =
    { status = Alive
    , position = ( 100, 2000 )
    , velocity = ( 0, 0 )
    , mass = 50
    , acceleration = ( 0, -8 )
    , simplecheck = collisionBox
    , collisionbox = [ collisionBox ]
    , extra = initExtraData
    , uid = 1
    }


initExtraData : Dict String DefinedTypes
initExtraData =
    Dict.fromList
        [ ( "model", CDPlayerModel nullModel )
        ]


collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 0
    , width = 70
    , height = 120
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GamePlayerInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 1000, 0 )
            , mass = 50
            , acceleration = ( 0, -8 )
            , simplecheck = collisionBox
            , collisionbox = [ collisionBox ]
            , extra = initExtraData
            , uid = 1
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    let
        model =
            dgetPlayer d.extra "model"
    in
    case msg of
        Tick _ ->
            case gct of
                GameSolidCollisionMsg cs ->
                    let
                        ( afterStateM, afterStateD ) =
                            stateControl t model d ggd

                        ( aftercheckM, aftercheckD ) =
                            preCheck t afterStateM afterStateD

                        ( afterVelM, afterVelD ) =
                            changePlayerVelocity t aftercheckD ggd aftercheckM

                        afterAccD =
                            putAccOn afterVelD

                        aftermoveD =
                            solidCollisionMove cs ggd afterAccD

                        aftermoveM =
                            afterMove afterVelM

                        exportmodel =
                            dsetPlayer "model" aftermoveM aftermoveD.extra
                    in
                    ( { aftermoveD | extra = exportmodel }, [], ggd )

                _ ->
                    if isAlive d then
                        let
                            ( afterStateM, afterStateD ) =
                                stateControl t model d ggd

                            ( aftercheckM, aftercheckD ) =
                                preCheck t afterStateM afterStateD

                            ( afterVelM, afterVelD ) =
                                changePlayerVelocity t aftercheckD ggd aftercheckM

                            afterAccD =
                                putAccOn afterVelD

                            aftermoveM =
                                afterMove afterVelM

                            exportmodel =
                                dsetPlayer "model" aftermoveM afterAccD.extra
                        in
                        ( { afterAccD | extra = exportmodel }, [], ggd )

                    else
                        let
                            afterAccD =
                                putAccOn d
                        in
                        ( afterAccD, [], ggd )

        KeyDown x ->
            let
                newmodel =
                    { model | originKeys = changebk x 1 model.originKeys }

                exportmodel =
                    dsetPlayer "model" newmodel d.extra
            in
            ( { d | extra = exportmodel }, [], ggd )

        KeyUp x ->
            let
                newmodel =
                    { model | originKeys = changebk x 0 model.originKeys }

                exportmodel =
                    dsetPlayer "model" newmodel d.extra
            in
            ( { d | extra = exportmodel }, [], ggd )

        MouseDown 0 mp ->
            if judgeMouse gd mp (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) then
                ( d, [], { ggd | selectobj = d.uid } )

            else
                ( d, [], ggd )

        _ ->
            case gct of
                GameClearVelocity ->
                    ( { d | velocity = ( 0, 0 ) }, [], ggd )

                GameUseEnergy mp e ->
                    let
                        ndd =
                            changeCVel d mp e
                    in
                    ( ndd, [], ggd )

                GameInterCollisionMsg s uid _ bs ->
                    case s of
                        "goomba" ->
                            if List.length bs >= 2 then
                                let
                                    ( _, pvy ) =
                                        d.velocity
                                in
                                if pvy < -200 then
                                    -- Rebound!
                                    ( reboundPlayer d, [ GameActorUidMsg uid (GameStringMsg "die") ], ggd )

                                else
                                    -- Die
                                    ( { d | status = Dead t }, [], ggd )

                            else
                                case bs of
                                    [ xx ] ->
                                        case xx.name of
                                            "col" ->
                                                ( { d | status = Dead t }, [], ggd )

                                            "reb" ->
                                                ( reboundPlayer d, [ GameActorUidMsg uid (GameStringMsg "die") ], ggd )

                                            _ ->
                                                ( d, [], ggd )

                                    _ ->
                                        ( d, [], ggd )

                        _ ->
                            ( d, [], ggd )

                _ ->
                    ( d, [], ggd )


queryModel : String -> ( Data, Int ) -> GameComponentTMsg
queryModel _ _ =
    NullGameComponentMsg


reboundPlayer : Data -> Data
reboundPlayer d =
    let
        ( pvx, pvy ) =
            d.velocity

        ( px, py ) =
            d.position

        nv =
            if pvy > -200 then
                200

            else if pvy > -300 then
                300

            else
                400
    in
    { d | velocity = ( pvx, nv ), position = ( px, py - 10 ) }
