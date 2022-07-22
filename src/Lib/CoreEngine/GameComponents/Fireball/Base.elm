module Lib.CoreEngine.GameComponents.Fireball.Base exposing (..)


type alias FireballInit =
    { initPosition : ( Int, Int )
    , size : Int
    , initVelocity : ( Float, Float )
    , uid : Int
    }
