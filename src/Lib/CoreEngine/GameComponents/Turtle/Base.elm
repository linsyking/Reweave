module Lib.CoreEngine.GameComponents.Turtle.Base exposing (..)


type alias TurtleInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , bulletEmitMethod : String
    , triggeruid : Int
    , uid : Int
    }
