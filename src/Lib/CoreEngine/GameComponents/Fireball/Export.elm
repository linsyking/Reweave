module Lib.CoreEngine.GameComponents.Fireball.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Fireball.Display exposing (view)
import Lib.CoreEngine.GameComponents.Fireball.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "fireball"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
