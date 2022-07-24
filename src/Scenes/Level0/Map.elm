module Scenes.Level0.Map exposing
    ( mapwidth
    , mymap
    )

{-| This is the doc for this module

@docs mapwidth

@docs mymap

-}

import Array2D
import Lib.Map.Longxi exposing (buildlxlongground, buildlxrock)
import Lib.Map.Poly exposing (buildPillar, buildrect)
import Lib.Map.Zhongyuan exposing (buildplatforms, buildzystick)


{-| mapwidth
-}
mapwidth : Int
mapwidth =
    300


sds : Array2D.Array2D Int
sds =
    Array2D.repeat mapwidth 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildlxlongground ( 2, 68 ) 7
        |> buildzystick ( 35, 63 )
        |> buildzystick ( 45, 60 )
        |> buildplatforms ( 51, 60 ) 8
        |> buildrect ( 69, 60 ) ( 22, 1 ) 2
        |> buildrect ( 72, 52 ) ( 12, 4 ) 2
        |> buildrect ( 68, 52 ) ( 4, 2 ) 2
        |> buildrect ( 84, 52 ) ( 4, 2 ) 2
        |> buildrect ( 69, 53 ) ( 4, 2 ) 2
        |> buildrect ( 83, 53 ) ( 4, 2 ) 2
        |> buildrect ( 116, 60 ) ( 3, 1 ) 2
        |> buildplatforms ( 85, 60 ) 12
        -- 2nd Master
        |> buildPillar ( 70, 61 ) 2
        |> buildPillar ( 87, 61 ) 2
        |> buildlxrock ( 20, 67 )
        |> buildlxrock ( 32, 67 )
        |> buildlxrock ( 33, 66 )
        |> buildlxrock ( 34, 65 )
        |> buildlxrock ( 34, 64 )
        |> buildlxrock ( 43, 60 )
        |> buildlxrock ( 41, 62 )
        |> buildlxrock ( 42, 61 )
        |> buildrect ( mapwidth - 1, 0 ) ( 1, 70 ) 2
        -- Tutorial
        -- |> buildlxrock ( 113, 59 )
        |> buildlxrock ( 125, 59 )
        |> buildrect ( 112, 58 ) ( 2, 1 ) 2
        |> buildzystick ( 127, 53 )
        |> buildplatforms ( 133, 66 ) 8
        |> buildplatforms ( 164, 25 ) 15
        |> buildPillar ( 163, 25 ) 8
        |> buildPillar ( 225, 26 ) 7
        |> buildPillar ( 191, 0 ) 3
        -- |> buildzystick ( 179, 18 )
        |> buildzystick ( 185, 16 )
        |> buildzystick ( 191, 16 )
        |> buildlxrock ( 185, 24 )
        |> buildlxrock ( 203, 24 )
        |> buildplatforms ( 225, 61 ) 10
        |> buildPillar ( 243, 45 ) 3
        |> buildPillar ( 243, 0 ) 7
        |> buildPillar ( 255, 40 ) 4
        |> buildPillar ( 255, 0 ) 6
        |> buildPillar ( 267, 25 ) 7
        |> buildPillar ( 267, 0 ) 3
        |> buildplatforms ( 268, 25 ) 6
