module Scenes.Home.Common exposing (..)

import Scenes.Home.LayerBase exposing (CommonData)
import Scenes.Home.LayerSettings exposing (LayerCT)


type alias XModel =
    { commonData : CommonData
    , layers : List ( String,  LayerCT )
    }
