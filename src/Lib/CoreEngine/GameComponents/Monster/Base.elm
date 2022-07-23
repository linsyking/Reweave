module Lib.CoreEngine.GameComponents.Monster.Base exposing (MonsterInit)

{-| This is the doc for this module

@docs BirdInit

-}


{-| BirdInit
-}
type alias MonsterInit =
    { initPosition : ( Int, Int )
    , size : ( Int, Int )
    , pic : String
    , triggeruid : Int
    , uid : Int
    }
