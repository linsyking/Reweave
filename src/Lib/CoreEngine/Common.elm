module Lib.CoreEngine.Common exposing (..)

{-| This is the doc for this module

@docs Model

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.LayerSettings exposing (LayerCT)


{-| Model
-}
type alias Model =
    { gameGlobalData : GameGlobalData
    , layers : List ( String, LayerCT )
    }
