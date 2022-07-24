module Scenes.Level2.Map exposing (mymap)

{-| This is the doc for this module

@docs mymap

-}

import Array2D
import Lib.Map.Donghai exposing (builddhbigrock)
import Lib.Map.Longxi exposing (buildlxlongground, buildlxplain, buildlxrock)
import Lib.Map.Poly exposing (buildPillar, buildrect)
import Lib.Map.Zhongyuan exposing (buildzystick)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 140 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 1
        |> buildlxlongground ( 7, 69 ) 60
        |> buildrect ( 139, 0 ) ( 1, 120 ) 2
        |> buildlxrock ( 5 + 1, 68 )
        |> buildlxrock ( 5 + 2, 68 )
        -- |> buildlxrock ( 5 + 1, 67 )
        |> buildlxrock ( 5 + 1, 69 )
        -- |> buildlxrock ( 5 + 1, 66 )
        |> buildlxrock ( 5 + 2, 69 )
        |> buildlxrock ( 5 + 3, 69 )
        |> buildlxrock ( 5 + 17, 68 )
        |> buildlxrock ( 33, 68 )
        |> buildlxrock ( 22, 67 )
        |> buildlxplain ( 36, 62 )
        |> builddhbigrock ( 1, 62 )
        |> builddhbigrock ( 37, 64 )
        |> buildlxplain ( 45, 57 )
        |> buildlxplain ( 48, 57 )
        |> buildlxplain ( 51, 57 )
        |> buildlxplain ( 54, 57 )
        |> buildlxrock ( 44, 56 )
        |> buildlxrock ( 44, 55 )
        |> buildlxrock ( 56, 56 )
        |> buildlxrock ( 56, 55 )
        |> buildrect ( 40, 69 ) ( 10, 1 ) 0
        |> buildlxplain ( 46, 50 )
        |> buildPillar ( 47, 29 ) 4
        |> buildlxplain ( 60, 45 )
        |> buildlxplain ( 66, 45 )
        |> buildlxrock ( 75, 68 )
        -- |> buildrect ( 88, 45 ) ( 10, 45 ) 1
        |> buildrect ( 87, 55 ) ( 10, 45 ) 2
        |> buildlxlongground ( 75, 69 ) 14
        |> buildlxlongground ( 7, 69 ) 7
        |> buildrect ( 86, 55 ) ( 2, 11 ) 0
        |> buildrect ( 98, 55 ) ( 2, 8 ) 0
        |> buildPillar ( 98, 20 ) 10
        |> buildPillar ( 119, 0 ) 3
        |> buildzystick ( 83, 55 )
        |> buildzystick ( 93, 37 )
        |> buildzystick ( 86, 37 )
        |> buildlxrock ( 83, 36 )
        |> buildlxrock ( 83, 35 )
        |> buildzystick ( 98, 19 )
        |> buildzystick ( 98, 19 )
        |> buildzystick ( 104, 19 )
        |> buildzystick ( 103, 22 )
        |> buildzystick ( 109, 22 )
        |> buildzystick ( 115, 22 )
        |> buildzystick ( 99, 25 )
        |> buildzystick ( 105, 25 )
        |> buildzystick ( 111, 25 )
        |> buildzystick ( 116, 25 )
        |> buildzystick ( 121, 25 )
        |> buildzystick ( 127, 25 )
        |> buildlxrock ( 120, 21 )
        |> buildlxrock ( 133, 24 )
        |> buildzystick ( 133, 13 )
        |> buildzystick ( 120, 10 )
        |> buildzystick ( 88, 10 )
        |> buildzystick ( 94, 10 )
        |> buildzystick ( 100, 10 )
        |> buildzystick ( 106, 10 )
        |> buildzystick ( 112, 10 )
