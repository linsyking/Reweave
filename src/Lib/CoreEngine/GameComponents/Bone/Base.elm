module Lib.CoreEngine.GameComponents.Bone.Base exposing (..)

{-| This is the doc for this module

@docs BoneInit

-}


{-| BoneInit
-}
type alias BoneInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , uid : Int
    }
