module Lib.CoreEngine.GameComponents.Exit.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, ExitInit, GameComponentMsgType, GameComponentTMsg(..), LifeStatus(..))


initData : Data
initData =
    { status = Alive
    , position = ( 300, 1100 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox
    , collisionbox = [ simplecheckBox ]
    , extra = Dict.empty
    , uid = 999
    }


simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 10
    , height = 90
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameExitInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ simplecheckBox ]
            , extra =
                Dict.fromList
                    [ ( "togo", CDString info.togo )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    case msg of
        Tick _ ->
            ( d, [], ggd )

        _ ->
            case gct of
                GameInterCollisionMsg "player" _ _ _ ->
                    ( d, [], ggd )

                _ ->
                    ( d, [], ggd )


queryModel : String -> ( Data, Int ) -> GameComponentTMsg
queryModel _ _ =
    NullGameComponentMsg
