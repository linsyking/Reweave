module Lib.CoreEngine.GameComponents.Player.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict exposing (Dict)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType, GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponents.Player.Acceleration exposing (putAccOn)
import Lib.CoreEngine.GameComponents.Player.Base exposing (changebk, nullModel)
import Lib.CoreEngine.GameComponents.Player.InputFilter exposing (afterMove, preCheck)
import Lib.CoreEngine.GameComponents.Player.InputHandler exposing (changePlayerVelocity)
import Lib.CoreEngine.GameComponents.Player.Movement exposing (playerMove)
import Lib.CoreEngine.GameComponents.Player.StatesControl exposing (stateControl)
import Lib.DefinedTypes.Base exposing (DefinedTypes(..))
import Lib.DefinedTypes.Parser exposing (dgetPlayer, dsetPlayer)


initData : Data
initData =
    { status = Alive
    , position = ( 100, 100 )
    , velocity = ( 0, 0 )
    , mass = 50
    , acceleration = ( 0, 0 )
    , simplecheck = collisionBox
    , collisionbox = [ collisionBox ]
    , extra = Dict.empty
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
updateModel msg _ ggd _ ( d, t ) =
    let
        model =
            dgetPlayer d.extra "model"
    in
    case msg of
        Tick _ ->
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
                    playerMove afterAccD ggd

                aftermoveM =
                    afterMove afterVelM

                exportmodel =
                    dsetPlayer "model" aftermoveM aftermoveD.extra
            in
            ( { aftermoveD | extra = exportmodel }, [], ggd )

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

        _ ->
            ( d, [], ggd )


queryModel : String -> ( Data, Int ) -> GameComponentTMsg
queryModel _ _ =
    NullGameComponentMsg
