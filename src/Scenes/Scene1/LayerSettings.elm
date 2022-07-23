module Scenes.Scene1.LayerSettings exposing
    ( LayerDataType(..)
    , LayerCT
    )

{-| This is the doc for this module

@docs LayerDataType

@docs LayerCT

-}

import Lib.Layer.Base exposing (..)
import Scenes.Scene1.Layer1.Export as L1
import Scenes.Scene1.Layer2.Export as L2
import Scenes.Scene1.LayerBase exposing (CommonData)


{-| LayerDataType
-}
type LayerDataType
    = Layer1Data L1.Data
    | Layer2Data L2.Data
    | NullLayerData


{-| LayerCT
-}
type alias LayerCT =
    Layer CommonData LayerDataType
