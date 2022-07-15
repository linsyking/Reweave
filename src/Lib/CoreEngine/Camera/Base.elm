module Lib.CoreEngine.Camera.Base exposing (..)


type alias CameraData =
    { position : ( Int, Int )
    , velocity : ( Float, Float )
    , visible : ( ( Int, Int ), ( Int, Int ) )
    }
