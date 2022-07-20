module Lib.CoreEngine.GameComponents.Bullet.Base exposing (..)


type alias BulletInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , uid : Int
    }
