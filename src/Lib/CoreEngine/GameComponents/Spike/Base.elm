module Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)


type alias SpikeInit =
    { initPosition : ( Int, Int )
    , direction : SpikeDirection
    , spikesnum : Int
    , visible : Bool
    , uid : Int
    }


type SpikeDirection
    = HorUp
    | HorDown
    | VerRight
    | VerLeft
