module Lib.CoreEngine.GameLayer.Export exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.CoreEngine.GameLayer.Display exposing (view)
import Lib.CoreEngine.GameLayer.Model exposing (initModel, updateModel)
import Lib.Layer.Base exposing (Layer)


type alias Data =
    Model


nullData : Data
nullData =
    { k = 0 }


layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
