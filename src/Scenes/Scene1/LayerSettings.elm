module Scenes.Scene1.LayerSettings exposing (..)

import Lib.Layer.Base exposing (..)
import Scenes.Scene1.Layer1.Export as L1
import Scenes.Scene1.Layer2.Export as L2
import Scenes.Scene1.LayerBase exposing (CommonData)


type LayerDataType
    = Layer1Data L1.Data
    | Layer2Data L2.Data
    | NullLayerData


type alias LayerCT =
    Layer CommonData LayerDataType
