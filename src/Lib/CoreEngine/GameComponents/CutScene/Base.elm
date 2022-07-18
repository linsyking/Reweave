module Lib.CoreEngine.GameComponents.CutScene.Base exposing (..)


type TalkingDir
    = Left
    | Right


type alias ExitInit =
    { initPosition : ( Int, Int )
    , initWidth : Int
    , initHeight : Int
    , talkings : List ( String, String, TalkingDir )
    }
