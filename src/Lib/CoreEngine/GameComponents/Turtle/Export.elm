module Lib.CoreEngine.GameComponents.Turtle.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Turtle.Display exposing (view)
import Lib.CoreEngine.GameComponents.Turtle.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "turtle"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
