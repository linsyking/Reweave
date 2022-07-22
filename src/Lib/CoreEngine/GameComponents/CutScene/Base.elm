module Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)


type alias CutSceneInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , uid : Int
    , talkings : List ( String, String )
    , isCol : Bool
    }
