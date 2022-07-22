module Lib.Audio.Base exposing (AudioOption(..), AudioRepo)

import Audio
import Time


type AudioOption
    = ALoop
    | AOnce


type alias AudioRepo =
    List ( String, Audio.Source, ( AudioOption, Time.Posix ) )
