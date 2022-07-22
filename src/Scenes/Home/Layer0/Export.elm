module Scenes.Home.Layer0.Export exposing (..)

{-| This is the doc for this module

@docs Data

@docs nullData

@docs layer

-}

import Lib.Layer.Base exposing (..)
import Scenes.Home.Layer0.Common exposing (ModelX)
import Scenes.Home.Layer0.Display exposing (dview)
import Scenes.Home.Layer0.Models exposing (initModel, updateModel)
import Scenes.Home.LayerBase exposing (CommonData)


{-| Data
-}
type alias Data =
    ModelX


{-| nullData
-}
nullData : Data
nullData =
    { s = 0
    }


{-| layer
-}
layer : Layer CommonData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = dview
    }
