module Lib.CoreEngine.GameComponents.Player.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict exposing (Dict)
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType, GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponents.Player.Acceleration exposing (putAccOn)
import Lib.CoreEngine.GameComponents.Player.Base exposing (changebk, nullModel)
import Lib.CoreEngine.GameComponents.Player.InputFilter exposing (afterMove, preCheck)
import Lib.CoreEngine.GameComponents.Player.InputHandler exposing (changePlayerVelocity)
import Lib.CoreEngine.GameComponents.Player.Movement exposing (solidCollisionMove)
import Lib.CoreEngine.GameComponents.Player.StatesControl exposing (stateControl)
import Lib.DefinedTypes.Base exposing (DefinedTypes(..))
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
    , extra = Dict.empty
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
initModel _ _ =
    initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    let
        model =
            dgetPlayer d.extra "model"

        dasdas =
            Debug.log "dsasd" model.playerStates
    in
    case msg of
        Tick _ ->
            case gct of
                GameSolidCollisionMsg cs ->
                    let
                        ( afterStateM, afterStateD ) =
                            stateControl t model d ggd

                        aftercheckM =
                            preCheck t afterStateM

                        ( afterVelM, afterVelD ) =
                            changePlayerVelocity t afterStateD ggd aftercheckM

                        afterAccD =
                            putAccOn ggd afterVelD

                        aftermoveD =
                            solidCollisionMove cs ggd afterAccD

                        aftermoveM =
                            afterMove afterVelM

                        exportmodel =
                            dsetPlayer "model" aftermoveM aftermoveD.extra
                    in
                    ( { aftermoveD | extra = exportmodel }, [], ggd )

                _ ->
                    let
                        ( afterStateM, afterStateD ) =
                            stateControl t model d ggd

                        aftercheckM =
                            preCheck t afterStateM

                        ( afterVelM, afterVelD ) =
                            changePlayerVelocity t afterStateD ggd aftercheckM

                        afterAccD =
                            putAccOn ggd afterVelD

                        aftermoveM =
                            afterMove afterVelM

                        exportmodel =
                            dsetPlayer "model" aftermoveM afterAccD.extra
                    in
                    ( { afterAccD | extra = exportmodel }, [], ggd )

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

        MouseDown 2 mp ->
            ( d, [], ggd )

        _ ->
            case gct of
                ClearVelocity ->
                    ( { d | velocity = ( 0, 0 ) }, [], ggd )

                _ ->
                    ( d, [], ggd )


queryModel : String -> ( Data, Int ) -> GameComponentTMsg
queryModel _ _ =
    NullGameComponentMsg
