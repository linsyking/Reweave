module Lib.CoreEngine.GameComponents.CutScene.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.CutScene.Display exposing (view)
import Lib.CoreEngine.GameComponents.CutScene.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "CutScene"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
