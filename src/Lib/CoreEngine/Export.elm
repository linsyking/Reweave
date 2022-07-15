module Lib.CoreEngine.Export exposing (..)

import Lib.CoreEngine.Base exposing (nullGameGlobalData)
import Lib.CoreEngine.Common exposing (Model)
import Lib.CoreEngine.Model exposing (initModel, updateModel, viewModel)
import Lib.Scene.Base exposing (Scene, SceneMsg)


type alias Data =
    Model


nullData : Data
nullData =
    { gameGlobalData = nullGameGlobalData
    , layers = []
    }


scene : Scene Data
scene =
    { init = initModel
    , update = updateModel
    , view = viewModel
    }


initEngine : Int -> SceneMsg -> Data
initEngine t sm =
    initModel t sm


genEngineScene : (SceneMsg -> Data) -> Scene Data
genEngineScene f =
    { init = \_ m -> f m
    , update = updateModel
    , view = viewModel
    }
