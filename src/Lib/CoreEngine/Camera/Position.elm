module Lib.CoreEngine.Camera.Position exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)


getPositionUnderCamera : ( Int, Int ) -> GameGlobalData -> ( Int, Int )
getPositionUnderCamera ( x, y ) ggd =
    let
        ( cx, cy ) =
            ggd.cameraPosition
    in
    ( x - cx, y - cy )
