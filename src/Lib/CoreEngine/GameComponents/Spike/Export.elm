module Lib.CoreEngine.GameComponents.Spike.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Spike.Display exposing (view)
import Lib.CoreEngine.GameComponents.Spike.Model exposing (initData, initModel, queryModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "spike"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    , query = queryModel
    }
