module Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)


type alias GoombaInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , uid : Int
    }
