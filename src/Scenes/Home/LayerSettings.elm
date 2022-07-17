module Scenes.Home.LayerSettings exposing (..)

import Lib.Layer.Base exposing (..)
import Scenes.Home.Layer1.Export as L1
import Scenes.Home.Layer0.Export as L0
import Scenes.Home.LayerBase exposing (CommonData)


type LayerDataType
    = Layer0Data L0.Data
    | Layer1Data L1.Data
    | NullLayerData


type alias LayerCT =
    Layer CommonData LayerDataType
