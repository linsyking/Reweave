module Lib.CoreEngine.GameComponents.CutScene.Base exposing (..)


type alias CutSceneInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , uid : Int
    , talkings : List ( String, String )
    }
