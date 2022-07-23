module Scenes.Level4.Map exposing
    ( sds
    , mymap
    )

{-| This is the doc for this module

@docs sds

@docs mymap

-}

import Array2D
import Lib.Map.Donghai exposing (builddhsmallrock, builddhrock)
import Lib.Map.Longxi exposing (bulidlxgroundleft, buildlxgroundmiddle, buildlxplain, buildlxrock)
import Lib.Map.Poly exposing (buildPillar, buildrect)
import Lib.Map.Zhongyuan exposing (buildzystick)

{-| sds
-}
sds : Array2D.Array2D Int
sds =
    Array2D.repeat 200 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 1
        |> buildrect ( 0, 68 ) ( 200, 2 ) 2
        -- bridge
        |> buildrect ( 20, 65 ) ( 3, 3 ) 1
        |> buildrect ( 23, 62 ) ( 3, 3 ) 1
        |> buildrect ( 26, 59 ) ( 1, 3 ) 1
        |> buildrect ( 26, 61 ) ( 20, 1 ) 1
        |> buildrect ( 45, 59 ) ( 1, 3 ) 1
        |> buildrect ( 46, 62 ) ( 3, 3 ) 1
        |> buildrect ( 49, 65 ) ( 3, 3 ) 1
        |> bulidlxgroundleft ( 55, 52 ) 
        |> builddhsmallrock ( 73, 55 )
        |> builddhrock ( 73, 65 ) 
        |> builddhrock ( 73, 66 ) 
        |> buildlxgroundmiddle ( 78, 51 ) 2
        |> buildrect ( 86, 58 ) ( 15, 10 ) 2
        |> buildrect ( 86, 49 ) ( 11, 9 ) 2
        |> buildrect ( 88, 45 ) ( 13, 4 ) 2
        |> buildlxgroundmiddle ( 101, 67 ) 8
        -- pavilion
        |> buildrect ( 116, 56 ) ( 1, 12 ) 1
        |> buildrect ( 105, 55 ) ( 12, 1 ) 1
        |> buildrect ( 105, 54 ) ( 1, 1 ) 1
        |> buildrect ( 116, 54 ) ( 1, 1 ) 1
        |> buildrect ( 117, 51 ) ( 3, 3 ) 1
        |> buildrect ( 120, 50 ) ( 15, 1 ) 1
        --|> buildrect ( 135, 51 ) ( 3, 3 ) 1
        |> buildrect ( 138, 54 ) ( 1, 1 ) 1
        |> buildrect ( 138, 55 ) ( 12, 1 ) 1
        |> buildrect ( 149, 54 ) ( 1, 1 ) 1
        |> buildrect ( 138, 56 ) ( 1, 7 ) 1
        |> buildrect ( 138, 67 ) ( 1, 1 ) 1
        -- inside
        |> buildrect ( 120, 63 ) ( 4, 1 ) 1
        |> buildrect ( 127, 58 ) ( 10, 1 ) 1
        -- final platform
        --|> buildrect ( 159, 50 ) ( 8, 1 ) 1
        |> buildrect ( 175, 65 ) ( 8, 3 ) 1
