module Lib.CoreEngine.GameComponents.Fish.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Fish.Display exposing (view)
import Lib.CoreEngine.GameComponents.Fish.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "fish"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
