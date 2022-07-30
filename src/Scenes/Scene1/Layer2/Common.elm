module Scenes.Scene1.Layer2.Common exposing
    ( ModelX
    , SModel
    )

{-| This is the doc for this module

@docs ModelX

@docs SModel

-}

import Base exposing (..)
import Lib.Component.Base exposing (..)


{-| ModelX
-}
type alias ModelX =
    { components : List Component
    }


{-| SModel
-}
type alias SModel =
    ( ModelX, Int )
