module Scenes.Level2.Map exposing (mymap)

{-| This is the doc for this module

@docs mymap

-}

import Array2D
import Lib.Map.Donghai exposing (builddhbigrock)
import Lib.Map.Longxi exposing (buildlxlongground, buildlxplain, buildlxrock)
import Lib.Map.Poly exposing (buildrect)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 1
        |> buildrect ( 9, 69 ) ( 80, 1 ) 1
        |> buildrect ( 119, 0 ) ( 1, 120 ) 2
        |> buildlxrock ( 5 + 1, 68 )
        |> buildlxrock ( 5 + 2, 68 )
        |> buildlxrock ( 5 + 1, 67 )
        |> buildlxrock ( 5 + 1, 69 )
        |> buildlxrock ( 5 + 1, 66 )
        |> buildlxrock ( 5 + 2, 69 )
        |> buildlxrock ( 5 + 3, 69 )
        |> buildlxrock ( 5 + 17, 68 )
        |> buildlxrock ( 33, 68 )
        |> buildlxplain ( 36, 62 )
        |> builddhbigrock ( 1, 62 )
        |> builddhbigrock ( 37, 64 )
        |> buildlxplain ( 45, 57 )
        |> buildlxplain ( 48, 57 )
        |> buildlxplain ( 51, 57 )
        |> buildlxplain ( 54, 57 )
        |> buildlxrock ( 44, 56 )
        |> buildlxrock ( 56, 56 )
        |> buildlxrock ( 56, 55 )
        |> buildrect ( 40, 69 ) ( 10, 1 ) 0
        |> buildlxplain ( 46, 50 )
        |> buildlxplain ( 60, 45 )
        |> buildlxrock ( 75, 68 )
        |> buildrect ( 86, 55 ) ( 14, 15 ) 2
        |> buildlxlongground ( 75, 69 ) 14
        |> buildrect ( 86, 55 ) ( 2, 11 ) 0
        |> buildrect ( 98, 55 ) ( 2, 8 ) 0
