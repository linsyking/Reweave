module Scenes.Level1.Map exposing (..)

import Array2D
import Lib.Map.Poly exposing (buildrect, buildrectT)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 1
        |> buildrect ( 0, 68 ) ( 120, 2 ) 1
        |> buildrect ( 0, 0 ) ( 120, 1 ) 1
        |> buildrect ( 119, 0 ) ( 1, 70 ) 1
        |> buildrectT ( 20, 64 ) ( 3, 3 )
        |> buildrect ( 27, 62 ) ( 15, 1 ) 1
        |> buildrect ( 27, 61 ) ( 1, 1 ) 1
        |> buildrect ( 41, 61 ) ( 1, 1 ) 1
        |> buildrect ( 47, 52 ) ( 10, 1 ) 1
        |> buildrect ( 60, 48 ) ( 10, 1 ) 1
        |> buildrect ( 75, 55 ) ( 44, 1 ) 1
