module Lib.CoreEngine.GameComponents.Spike.Base exposing
    ( SpikeDirection(..)
    , SpikeInit
    )

{-| This is the doc for this module

@docs SpikeDirection

@docs SpikeInit

-}


{-| SpikeInit
-}
type alias SpikeInit =
    { initPosition : ( Int, Int )
    , direction : SpikeDirection
    , spikesnum : Int
    , visible : Bool
    , uid : Int
    }


{-| SpikeDirection
-}
type SpikeDirection
    = HorUp
    | HorDown
    | VerRight
    | VerLeft
