module Lib.CoreEngine.GameComponents.Bullet.Base exposing (BulletInit)

{-| This is the doc for this module

@docs BulletInit

-}


{-| BulletInit
-}
type alias BulletInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , picture : String
    , uid : Int
    }
