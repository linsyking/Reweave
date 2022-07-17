module Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (..)


type alias GoombaEmitterInit =
    { initPosition : ( Int, Int )
    , interval : Int
    , goombaVelocity : ( Float, Float )
    , uid : Int
    }
