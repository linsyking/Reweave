module Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)

{-| This is the doc for this module

@docs getPositionUnderCamera

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)


{-| getPositionUnderCamera
-}
getPositionUnderCamera : ( Int, Int ) -> GameGlobalData -> ( Int, Int )
getPositionUnderCamera ( x, y ) ggd =
    let
        ( cx, cy ) =
            ggd.camera.position
    in
    ( x - cx, y - cy )
