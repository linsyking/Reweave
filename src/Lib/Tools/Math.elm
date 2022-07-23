module Lib.Tools.Math exposing
    ( rfint
    , tupleIntToFloat
    )

{-| This is the doc for this module

@docs rfint

@docs tupleIntToFloat

-}

import Lib.CoreEngine.Base exposing (brickSize)


{-| rfint
-}
rfint : Int -> Int
rfint x =
    floor (toFloat x / toFloat brickSize)


{-| tupleIntToFloat
-}
tupleIntToFloat : ( Int, Int ) -> ( Float, Float )
tupleIntToFloat ( x, y ) =
    ( toFloat x, toFloat y )
