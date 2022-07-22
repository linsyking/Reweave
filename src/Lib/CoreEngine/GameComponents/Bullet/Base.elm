module Lib.CoreEngine.GameComponents.Bullet.Base exposing (BulletInit)


type alias BulletInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , picture : String
    , uid : Int
    }
