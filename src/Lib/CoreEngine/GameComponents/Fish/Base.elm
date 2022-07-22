module Lib.CoreEngine.GameComponents.Fish.Base exposing (FishInit)

{-| This is the doc for this module

@docs FishInit

-}


{-| FishInit
-}
type alias FishInit =
    { initPosition : ( Int, Int )
    , triggeruid : Int
    , uid : Int
    }
