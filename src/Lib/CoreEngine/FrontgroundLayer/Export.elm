module Lib.CoreEngine.FrontgroundLayer.Export exposing (..)

import Lib.CoreEngine.Base exposing (GameGloablData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.CoreEngine.FrontgroundLayer.Display exposing (view)
import Lib.CoreEngine.FrontgroundLayer.Model exposing (initModel, updateModel)
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
