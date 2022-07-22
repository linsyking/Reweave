module Scenes.Home.Export exposing (..)

{-| This is the doc for this module

@docs Data

@docs nullData

@docs scene

-}

import Lib.Scene.Base exposing (..)
import Scenes.Home.Common exposing (XModel)
import Scenes.Home.LayerBase exposing (CommonData)
import Scenes.Home.Model exposing (initModel, updateModel, viewModel)


{-| Data
-}
type alias Data =
    XModel


{-| nullData
-}
nullData : Data
nullData =
    { commonData = CommonData 0
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
