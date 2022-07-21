module Lib.CoreEngine.GameComponents.Fish.Base exposing (..)


type alias FishInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , bulletEmitMethod : String
    , triggeruid : Int
    , uid : Int
    }
