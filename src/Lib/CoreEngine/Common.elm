module Lib.CoreEngine.Common exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.LayerSettings exposing (LayerCT)


type alias Model =
    { gameGlobalData : GameGlobalData
    , layers : List ( String, LayerCT )
    }
