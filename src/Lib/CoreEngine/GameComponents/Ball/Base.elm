module Lib.CoreEngine.GameComponents.Ball.Base exposing (BallInit)

{-| This is the doc for this module

@docs BallInit

-}


{-| BallInit
-}
type alias BallInit =
    { initPosition : ( Int, Int )
    , size : Int
    , uid : Int
    }
