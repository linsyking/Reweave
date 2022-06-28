module Scenes.Scene1.Common exposing (..)

import Scenes.Scene1.LayerBase exposing (CommonData)
import Scenes.Scene1.LayerSettings exposing (LayerCT)


type alias XModel =
    { commonData : CommonData
    , layers : List ( String, LayerCT )
    }
