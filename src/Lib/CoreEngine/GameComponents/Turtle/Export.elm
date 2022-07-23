module Lib.CoreEngine.GameComponents.Turtle.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Turtle.Display exposing (view)
import Lib.CoreEngine.GameComponents.Turtle.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "turtle"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
