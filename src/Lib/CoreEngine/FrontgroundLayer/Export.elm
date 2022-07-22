module Lib.CoreEngine.FrontgroundLayer.Export exposing (..)

{-| This is the doc for this module

@docs Data

@docs nullData

@docs layer

-}

import Lib.CoreEngine.Base exposing (GameGlobalData, nullGameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.CoreEngine.FrontgroundLayer.Display exposing (view)
import Lib.CoreEngine.FrontgroundLayer.Model exposing (initModel, updateModel)
import Lib.Layer.Base exposing (Layer, LayerMsg(..))


{-| Data
-}
type alias Data =
    Model


{-| nullData
-}
nullData : Data
nullData =
    initModel 0 NullLayerMsg nullGameGlobalData


{-| layer
-}
layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
