module Lib.CoreEngine.GameComponents.Fireball.Base exposing (FireballInit)


type alias FireballInit =
    { initPosition : ( Int, Int )
    , size : Int
    , initVelocity : ( Float, Float )
    , uid : Int
    }
