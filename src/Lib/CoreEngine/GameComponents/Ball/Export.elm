module Lib.CoreEngine.GameComponents.Ball.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Ball.Display exposing (view)
import Lib.CoreEngine.GameComponents.Ball.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "fireball"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
