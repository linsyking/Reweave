module Scenes.Home.Export exposing (..)

import Lib.Scene.Base exposing (..)
import Scenes.Home.Common exposing (XModel)
import Scenes.Home.LayerBase exposing (CommonData)
import Scenes.Home.Model exposing (initModel, updateModel, viewModel)


type alias Data =
    XModel


nullData : Data
nullData =
    { commonData = CommonData 0
    , layers = []
    }


scene : Scene Data
scene =
    { init = initModel
    , update = updateModel
    , view = viewModel
    }
