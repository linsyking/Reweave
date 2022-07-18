module Lib.CoreEngine.GameComponents.CutScene.Base exposing (..)


type alias CutSceneInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , talkings : List ( String, String, Bool )
    }
