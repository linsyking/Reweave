module Lib.CoreEngine.GameComponents.Fireball.Base exposing (FireballInit)

{-| This is the doc for this module

@docs FireballInit

-}


{-| FireballInit
-}
type alias FireballInit =
    { initPosition : ( Int, Int )
    , size : Int
    , initVelocity : ( Float, Float )
    , uid : Int
    }
