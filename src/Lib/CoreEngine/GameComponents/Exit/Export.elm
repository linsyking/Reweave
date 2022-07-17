module Lib.CoreEngine.GameComponents.Exit.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Exit.Display exposing (view)
import Lib.CoreEngine.GameComponents.Exit.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "exit"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
