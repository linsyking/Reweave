module Lib.Audio.Base exposing
    ( AudioOption(..)
    , AudioRepo
    )

{-| This is the doc for this module

@docs AudioOption

@docs AudioRepo

-}

import Audio
import Time


{-| AudioOption
-}
type AudioOption
    = ALoop
    | AOnce


{-| AudioRepo
-}
type alias AudioRepo =
    List ( String, Audio.Source, ( AudioOption, Time.Posix ) )
