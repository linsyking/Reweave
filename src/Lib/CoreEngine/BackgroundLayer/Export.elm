module Lib.CoreEngine.BackgroundLayer.Export exposing (..)

import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.BackgroundLayer.Display exposing (view)
import Lib.CoreEngine.BackgroundLayer.Modle exposing (initModel, updateModel)
import Lib.CoreEngine.Base exposing (GameGloablData)
import Lib.Layer.Base exposing (Layer)


type alias Data =
    Model


nullData : Data
nullData =
    { k = 0 }


layer : Layer GameGloablData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
