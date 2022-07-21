module Scenes.Level0.Map exposing (..)

import Array2D
import Lib.Map.Longxi exposing (buildlxlongground, buildlxrock)
import Lib.Map.Poly exposing (buildrect)
import Lib.Map.Zhongyuan exposing (buildplatforms, buildzystick)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildlxlongground ( 2, 68 ) 7
        |> buildzystick ( 35, 63 )
        |> buildzystick ( 45, 60 )
        |> buildplatforms ( 51, 60 ) 8
        |> buildrect ( 65, 60 ) ( 20, 1 ) 2
        |> buildrect ( 72, 52 ) ( 12, 4 ) 2
        |> buildrect ( 68, 52 ) ( 4, 2 ) 2
        |> buildrect ( 84, 52 ) ( 4, 2 ) 2
        |> buildrect ( 69, 53 ) ( 4, 2 ) 2
        |> buildrect ( 83, 53 ) ( 4, 2 ) 2
        |> buildplatforms ( 85, 60 ) 7
        |> buildrect ( 116, 60 ) ( 3, 1 ) 2
        |> buildlxrock ( 20, 67 )
        |> buildlxrock ( 32, 67 )
        |> buildlxrock ( 33, 66 )
        |> buildlxrock ( 34, 65 )
        |> buildlxrock ( 34, 64 )
        |> buildlxrock ( 43, 60 )
        |> buildlxrock ( 41, 62 )
        |> buildlxrock ( 42, 61 )
