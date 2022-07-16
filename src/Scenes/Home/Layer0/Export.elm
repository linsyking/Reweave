module Scenes.Home.Layer0.Export exposing (..)

import Lib.Layer.Base exposing (..)
import Scenes.Home.Layer0.Common exposing (ModelX)
import Scenes.Home.Layer0.Display exposing (dview)
import Scenes.Home.Layer0.Models exposing (initModel, updateModel)
import Scenes.Home.LayerBase exposing (CommonData)


type alias Data =
    ModelX


nullData : Data
nullData =
    { s = 0
    }


layer : Layer CommonData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = dview
    }
