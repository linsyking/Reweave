module Lib.CoreEngine.GameComponents.Bone.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Bone.Display exposing (view)
import Lib.CoreEngine.GameComponents.Bone.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for bone
init : the init function for bone
update : the update function for bone
view : the view function for bone
query : bone does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "bone"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
