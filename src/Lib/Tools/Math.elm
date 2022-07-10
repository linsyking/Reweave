module Lib.Tools.Math exposing (..)

import Lib.CoreEngine.Base exposing (brickSize)


rfint : Int -> Int
rfint x =
    floor (toFloat x / toFloat brickSize)


tupleIntToFloat : ( Int, Int ) -> ( Float, Float )
tupleIntToFloat ( x, y ) =
    ( toFloat x, toFloat y )
