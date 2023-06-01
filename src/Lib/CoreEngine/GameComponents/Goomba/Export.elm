module Lib.CoreEngine.GameComponents.Goomba.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Goomba.Display exposing (view)
import Lib.CoreEngine.GameComponents.Goomba.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for goomba
init : the init function for goomba
update : the update function for goomba
view : the view function for goomba
query : goomba does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "goomba"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
