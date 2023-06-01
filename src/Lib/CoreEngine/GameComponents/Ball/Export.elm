module Lib.CoreEngine.GameComponents.Ball.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Ball.Display exposing (view)
import Lib.CoreEngine.GameComponents.Ball.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for ball
init : the init function for ball
update : the update function for ball
view : the view function for ball
query : ball does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "ball"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
