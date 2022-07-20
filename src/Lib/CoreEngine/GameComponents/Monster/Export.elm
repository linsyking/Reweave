module Lib.CoreEngine.GameComponents.Monster.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Monster.Display exposing (view)
import Lib.CoreEngine.GameComponents.Monster.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "monster"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
