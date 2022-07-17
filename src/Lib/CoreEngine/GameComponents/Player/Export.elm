module Lib.CoreEngine.GameComponents.Player.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Display exposing (view)
import Lib.CoreEngine.GameComponents.Player.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "player"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
