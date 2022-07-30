module Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)

{-| This is the doc for this module

@docs GoombaEmitterInit

-}


{-| GoombaEmitterInit
-}
type alias GoombaEmitterInit =
    { initPosition : ( Int, Int )
    , interval : Int
    , goombaVelocity : ( Float, Float )
    , uid : Int
    }
