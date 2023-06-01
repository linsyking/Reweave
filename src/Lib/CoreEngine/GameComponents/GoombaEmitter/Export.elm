module Lib.CoreEngine.GameComponents.GoombaEmitter.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Display exposing (view)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for goombaemitter
init : the init function for goombaemitter
update : the update function for goombaemitter
view : the view function for goombaemitter
query : goombaemitter does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "goombaemitter"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
