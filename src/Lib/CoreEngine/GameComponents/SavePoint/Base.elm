module Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)

{-| This is the doc for this module

@docs SavePointInit

-}


{-| SavePointInit
-}
type alias SavePointInit =
    { initPosition : ( Int, Int )
    , uid : Int
    }
