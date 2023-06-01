module Lib.Tools.Math exposing
    ( rfint
    , tupleIntToFloat
    , addIntVec
    , addFloatVec
    )

{-| This module exports some tools we can use to calculate.

@docs rfint

@docs tupleIntToFloat

@docs addIntVec

@docs addFloatVec

-}

import Lib.CoreEngine.Base exposing (brickSize)


{-| rfint
Get the brick-position.
-}
rfint : Int -> Int
rfint x =
    floor (toFloat x / toFloat brickSize)


{-| tupleIntToFloat
-}
tupleIntToFloat : ( Int, Int ) -> ( Float, Float )
tupleIntToFloat ( x, y ) =
    ( toFloat x, toFloat y )


{-| addIntVec
-}
addIntVec : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
addIntVec ( a, b ) ( c, d ) =
    ( a + c, b + d )


{-| addFloatVec
-}
addFloatVec : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
addFloatVec ( a, b ) ( c, d ) =
    ( a + c, b + d )
