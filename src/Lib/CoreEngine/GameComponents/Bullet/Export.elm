module Lib.CoreEngine.GameComponents.Bullet.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Bullet.Display exposing (view)
import Lib.CoreEngine.GameComponents.Bullet.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for bullet
init : the init function for bullet
update : the update function for bullet
view : the view function for bullet
query : bullet does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "bullet"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
