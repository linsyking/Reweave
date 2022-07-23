module Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)

{-| This is the doc for this module

@docs BoneInit

-}


{-| BoneInit
-}
type alias BoneInit =
    { initPosition : ( Int, Int )
    , initSize : Int
    , uid : Int
    }
