module Scenes.Level1.Map exposing (..)

import Array2D
import Lib.Map.Poly exposing (buildrect, buildrectT)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 )
        |> buildrectT ( 20, 64 ) ( 3, 3 )
        |> buildrect ( 25, 61 ) ( 3, 3 )
        |> buildrect ( 29, 58 ) ( 3, 3 )
        |> buildrect ( 35, 54 ) ( 3, 3 )
        |> buildrect ( 39, 50 ) ( 3, 3 )
        |> buildrect ( 43, 46 ) ( 3, 3 )
        |> buildrect ( 40, 37 ) ( 3, 3 )
        |> buildrect ( 49, 43 ) ( 3, 3 )
        |> buildrect ( 53, 40 ) ( 3, 3 )
        |> buildrect ( 60, 50 ) ( 13, 3 )
        |> buildrect ( 0, 68 ) ( 120, 2 )
        |> buildrect ( 0, 0 ) ( 120, 1 )
        |> buildrect ( 119, 0 ) ( 1, 70 )
