module Scenes.Scene1.Layer2.Common exposing (..)

import Base exposing (..)
import Lib.Component.Base exposing (..)


type alias ModelX =
    { components : List Component
    }


type alias SModel =
    ( ModelX, Int )
