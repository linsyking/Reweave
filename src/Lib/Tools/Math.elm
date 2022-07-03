module Lib.Tools.Math exposing (..)


rfint : Int -> Int
rfint x =
    floor (toFloat x / 8)


tupleIntToFloat : ( Int, Int ) -> ( Float, Float )
tupleIntToFloat ( x, y ) =
    ( toFloat x, toFloat y )
