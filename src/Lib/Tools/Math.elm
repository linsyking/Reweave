module Lib.Tools.Math exposing
    ( rfint
    , tupleIntToFloat
    , addIntVec
    , addFloatVec
    , timeFromFrame
    )

{-| This module exports some tools we can use to calculate.

@docs rfint

@docs tupleIntToFloat

@docs addIntVec

@docs addFloatVec

@docs timeFromFrame

-}

import Lib.CoreEngine.Base exposing (brickSize)
import MainConfig exposing (timeInterval)


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


{-| From frames to time
-}
timeFromFrame : Int -> String
timeFromFrame t =
    let
        total =
            t * floor timeInterval

        milliSec =
            modBy 1000 total

        millisecS =
            if milliSec < 10 then
                "00" ++ String.fromInt milliSec

            else if milliSec < 100 then
                "0" ++ String.fromInt milliSec

            else
                String.fromInt milliSec

        seconds =
            modBy 60 <| total // 1000

        secS =
            if seconds < 10 then
                "0" ++ String.fromInt seconds

            else
                String.fromInt seconds

        minutes =
            modBy 60 <| total // 60000

        minS =
            if minutes < 10 then
                "0" ++ String.fromInt minutes

            else
                String.fromInt minutes
    in
    minS ++ ":" ++ secS ++ "." ++ millisecS
