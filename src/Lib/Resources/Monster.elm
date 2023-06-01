module Lib.Resources.Monster exposing (isInCollected)

{-| This is the doc for this module

@docs isInCollected

-}


{-| isInCollected
-}
isInCollected : String -> List String -> Bool
isInCollected s cs =
    List.any (\x -> x == s) cs
