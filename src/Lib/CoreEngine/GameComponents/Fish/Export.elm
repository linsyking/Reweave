module Lib.CoreEngine.GameComponents.Fish.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Fish.Display exposing (view)
import Lib.CoreEngine.GameComponents.Fish.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for fish
init : the init function for fish
update : the update function for fish
view : the view function for fish
query : fish does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "fish"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
