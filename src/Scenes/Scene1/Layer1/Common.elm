module Scenes.Scene1.Layer1.Common exposing
    ( ModelX
    , SModel
    )

{-| This is the doc for this module

@docs ModelX

@docs SModel

-}

import Base exposing (..)


{-| ModelX
-}
type alias ModelX =
    { s : Int
    }


{-| SModel
-}
type alias SModel =
    ( ModelX, Int )
