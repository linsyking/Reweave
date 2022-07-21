module Lib.CoreEngine.FrontgroundLayer.Export exposing (..)

import Array
import Canvas exposing (group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.CoreEngine.FrontgroundLayer.Display exposing (view)
import Lib.CoreEngine.FrontgroundLayer.Model exposing (initModel, updateModel)
import Lib.Layer.Base exposing (Layer)


type alias Data =
    Model


nullData : Data
nullData =
    { render = \_ _ _ -> group [] [], components = Array.empty, fpsrepo = [], ispaused = False }


layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
