module Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)

{-| This is the doc for this module

@docs CutSceneInit

-}


{-| CutSceneInit
-}
type alias CutSceneInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , uid : Int
    , talkings : List ( String, String )
    , isCol : Bool
    }
