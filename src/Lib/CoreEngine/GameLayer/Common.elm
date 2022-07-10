module Lib.CoreEngine.GameLayer.Common exposing (..)

import Array exposing (Array)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)


type alias Model =
    { player : GameComponent
    , actors : Array GameComponent
    }
