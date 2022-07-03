module Lib.CoreEngine.GameComponents.Player.Model exposing (..)

import Base exposing (GlobalData, Msg)
import Dict
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType, GameComponentTMsg(..), LifeStatus(..))


initData : Data
initData =
    { status = Alive
    , position = ( 100, 100 )
    , velocity = ( 0, 0 )
    , acceleration = ( 0, 0 )
    , simplecheck = collisionBox
    , collisionbox = [ collisionBox ]
    , extra = Dict.empty
    }


collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 0
    , width = 100
    , height = 300
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ _ =
    initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel _ _ ggd _ ( d, _ ) =
    ( d, [], ggd )


queryModel : String -> ( Data, Int ) -> GameComponentTMsg
queryModel _ _ =
    NullGameComponentMsg
