module Lib.CoreEngine.GameComponents.Spike.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Spike.Display exposing (view)
import Lib.CoreEngine.GameComponents.Spike.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for spike
init : the init function for spike
update : the update function for spike
view : the view function for spike
query : spike does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "spike"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
