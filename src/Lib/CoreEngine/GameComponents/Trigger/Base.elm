module Lib.CoreEngine.GameComponents.Trigger.Base exposing (TriggerInit)

{-| This is the doc for this module

@docs TriggerInit

-}


{-| TriggerInit
-}
type alias TriggerInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , triggerUID : Int
    , msg : String
    , uid : Int
    }
