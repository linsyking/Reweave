module Lib.CoreEngine.GameComponents.Fireball.Base exposing (..)


type alias BulletInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , picture : String
    , uid : Int
    }
