module Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)

{-| This is the doc for this module

@docs EnergyCrystalInit

-}


{-| EnergyCrystalInit
-}
type alias EnergyCrystalInit =
    { initPosition : ( Int, Int )
    , energy : Int
    , recoverable : Bool
    , uid : Int
    }
