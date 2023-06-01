module Lib.CoreEngine.GameComponents.Monster.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Monster.Display exposing (view)
import Lib.CoreEngine.GameComponents.Monster.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for bird
init : the init function for bird
update : the update function for bird
view : the view function for bird
query : bird does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "bird"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
