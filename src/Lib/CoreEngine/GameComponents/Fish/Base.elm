module Lib.CoreEngine.GameComponents.Fish.Base exposing (..)


type alias FishInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , picture : String
    , bulletEmitMethod : String
    , uid : Int
    }
