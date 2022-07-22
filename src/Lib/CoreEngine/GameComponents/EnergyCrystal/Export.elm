module Lib.CoreEngine.GameComponents.Bone.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Bone.Display exposing (view)
import Lib.CoreEngine.GameComponents.Bone.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "bone"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
