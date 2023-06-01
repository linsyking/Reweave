module Lib.CoreEngine.GameComponents.Fireball.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Fireball.Display exposing (view)
import Lib.CoreEngine.GameComponents.Fireball.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for fireball
init : the init function for fireball
update : the update function for fireball
view : the view function for fireball
query : fireball does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "fireball"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
