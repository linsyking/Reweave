module Lib.CoreEngine.FrontgroundLayer.Export exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData, nullGameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.CoreEngine.FrontgroundLayer.Display exposing (view)
import Lib.CoreEngine.FrontgroundLayer.Model exposing (initModel, updateModel)
import Lib.Layer.Base exposing (Layer, LayerMsg(..))


type alias Data =
    Model


nullData : Data
nullData =
    initModel 0 NullLayerMsg nullGameGlobalData


layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
