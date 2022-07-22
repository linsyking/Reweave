module Lib.CoreEngine.Camera.Base exposing (CameraData)


type alias CameraData =
    { position : ( Int, Int )
    , velocity : ( Float, Float )
    , visible : ( ( Int, Int ), ( Int, Int ) )
    , inbox : ( ( Float, Float ), ( Float, Float ) )
    }
