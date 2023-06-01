module Lib.CoreEngine.Camera.Base exposing (CameraData)

{-| This is the doc for this module

@docs CameraData

-}


{-| CameraData
-}
type alias CameraData =
    { position : ( Int, Int )
    , velocity : ( Float, Float )
    , visible : ( ( Int, Int ), ( Int, Int ) )
    , inbox : ( ( Float, Float ), ( Float, Float ) )
    }
