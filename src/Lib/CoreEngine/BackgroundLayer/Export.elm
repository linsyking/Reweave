module Lib.CoreEngine.BackgroundLayer.Export exposing (..)

{-| This is the doc for this module

@docs Data

@docs nullData

@docs layer

-}

import Canvas exposing (group)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.BackgroundLayer.Display exposing (view)
import Lib.CoreEngine.BackgroundLayer.Model exposing (initModel, updateModel)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Layer.Base exposing (Layer)


{-| Data
-}
type alias Data =
    Model


{-| nullData
-}
nullData : Data
nullData =
    { render = \_ _ _ -> group [] [] }


{-| layer
-}
layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
