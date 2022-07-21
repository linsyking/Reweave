module Lib.CoreEngine.GameComponents.Fireball.Base exposing (..)


type alias FireballInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , uid : Int
    }
