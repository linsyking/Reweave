module Scenes.Scene1.Export exposing
    ( Data
    , nullData
    , scene
    )

{-| This is the doc for this module

@docs Data

@docs nullData

@docs scene

-}

import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Common exposing (XModel)
import Scenes.Scene1.LayerBase exposing (CommonData)
import Scenes.Scene1.Model exposing (initModel, updateModel, viewModel)


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
