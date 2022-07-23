module Lib.CoreEngine.Export exposing
    ( Data
    , nullData
    , scene
    , initEngine
    , genEngineScene
    )

{-| This is the doc for this module

@docs Data

@docs nullData

@docs scene

@docs initEngine

@docs genEngineScene

-}

import Lib.CoreEngine.Base exposing (nullGameGlobalData)
import Lib.CoreEngine.Common exposing (Model)
import Lib.CoreEngine.Model exposing (initModel, updateModel, viewModel)
import Lib.Scene.Base exposing (Scene, SceneMsg)


{-| Data
-}
type alias Data =
    Model


{-| nullData
-}
nullData : Data
nullData =
    { gameGlobalData = nullGameGlobalData
    , layers = []
    }


{-| scene
-}
scene : Scene Data
scene =
    { init = initModel
    , update = updateModel
    , view = viewModel
    }


{-| initEngine
-}
initEngine : Int -> SceneMsg -> Data
initEngine t sm =
    initModel t sm


{-| genEngineScene
-}
genEngineScene : (Int -> SceneMsg -> Data) -> Scene Data
genEngineScene f =
    { init = \t m -> f t m
    , update = updateModel
    , view = viewModel
    }
