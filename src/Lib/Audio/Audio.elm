module Lib.Audio.Audio exposing (..)

import Audio exposing (AudioData)
import Duration
import Lib.Audio.Base exposing (..)
import Time


loadAudio : AudioRepo -> String -> Audio.Source -> AudioOption -> Time.Posix -> AudioRepo
loadAudio repo name source opt t =
    let
        filterrepo =
            List.filter (\( n, _, _ ) -> n /= name) repo
    in
    filterrepo ++ [ ( name, source, ( opt, t ) ) ]


stopAudio : AudioRepo -> String -> AudioRepo
stopAudio repo s =
    List.filter (\( name, _, _ ) -> name /= s) repo


getAudio : AudioData -> AudioRepo -> List Audio.Audio
getAudio ad repo =
    List.map
        (\( _, sound, ( opt, s ) ) ->
            case opt of
                ALoop ->
                    let
                        default =
                            Audio.audioDefaultConfig
                    in
                    Audio.audioWithConfig { default | loop = Just (Audio.LoopConfig (Duration.seconds 0) (Audio.length ad sound)) } sound s

                AOnce ->
                    Audio.audio sound s
        )
        repo
