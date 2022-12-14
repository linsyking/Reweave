module Lib.CoreEngine.GameComponents.Turtle.Base exposing (TurtleInit)

{-| This is the doc for this module

@docs TurtleInit

-}


{-| TurtleInit
-}
type alias TurtleInit =
    { initPosition : ( Int, Int )
    , triggeruid : Int
    , uid : Int
    }
