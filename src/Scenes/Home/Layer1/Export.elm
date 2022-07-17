module Scenes.Home.Layer1.Export exposing (..)

import Lib.Layer.Base exposing (..)
import Scenes.Home.Layer1.Common exposing (ModelX)
import Scenes.Home.Layer1.Display exposing (dview)
import Scenes.Home.Layer1.Models exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


type alias Data =
    ModelX


nullData : Data
nullData =
    { ico = 1
    , start = initButton "Start" ( 960, 400 ) 15 10
    , help = initButton "Help" ( 960, 500 ) 15 10
    , map = initButton "Map" ( 960, 600 ) 15 10
    }


layer : Layer CommonData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = dview
    }