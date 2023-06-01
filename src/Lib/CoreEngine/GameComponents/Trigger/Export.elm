module Lib.CoreEngine.GameComponents.Trigger.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Trigger.Display exposing (view)
import Lib.CoreEngine.GameComponents.Trigger.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for trigger
init : the init function for trigger
update : the update function for trigger
view : the view function for trigger
query : trigger does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "trigger"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
