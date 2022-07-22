module Lib.CoreEngine.GameComponents.Ball.Base exposing (..)


type alias FireballInit =
    { initPosition : ( Int, Int )
    , size : Int
    , initVelocity : ( Float, Float )
    , uid : Int
    }
