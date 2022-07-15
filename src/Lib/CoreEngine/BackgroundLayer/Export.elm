module Lib.CoreEngine.BackgroundLayer.Export exposing (..)

import Canvas exposing (group)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.BackgroundLayer.Display exposing (view)
import Lib.CoreEngine.BackgroundLayer.Model exposing (initModel, updateModel)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Layer.Base exposing (Layer)


type alias Data =
    Model


nullData : Data
nullData =
    { render = \_ _ _ -> group [] [] }


layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
