module Scenes.Scene1.Layer2.Export exposing (..)

import Lib.Layer.Base exposing (..)
import Scenes.Scene1.Layer2.Common exposing (ModelX)
import Scenes.Scene1.Layer2.Display exposing (dview)
import Scenes.Scene1.Layer2.Models exposing (initModel, updateModel)
import Scenes.Scene1.LayerBase exposing (CommonData)


type alias Data =
    ModelX


nullData : Data
nullData =
    { components = []
    }


layer : Layer CommonData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = dview
    }
