module Lib.CoreEngine.GameComponents.Bird.Base exposing (BirdInit)

{-| This is the doc for this module

@docs BirdInit

-}


{-| BirdInit
-}
type alias BirdInit =
    { initPosition : ( Int, Int )
    , triggeruid : Int
    , uid : Int
    }
