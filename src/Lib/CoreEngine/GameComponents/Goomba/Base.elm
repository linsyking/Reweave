module Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)

{-| This is the doc for this module

@docs GoombaInit

-}


{-| GoombaInit
-}
type alias GoombaInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , uid : Int
    }
