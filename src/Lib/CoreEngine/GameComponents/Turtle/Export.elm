module Lib.CoreEngine.GameComponents.Turtle.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Turtle.Display exposing (view)
import Lib.CoreEngine.GameComponents.Turtle.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for turtle
init : the init function for turtle
update : the update function for turtle
view : the view function for turtle
query : turtle does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "turtle"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
