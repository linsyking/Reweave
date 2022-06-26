module Scenes.Scene1.Export exposing (..)

import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Common exposing (XModel)
import Scenes.Scene1.LayerBase exposing (CommonData)
import Scenes.Scene1.Model exposing (initModel, updateModel, viewModel)


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
