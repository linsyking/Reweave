module Scenes.Level1.Map exposing (..)

import Array2D
import Lib.Map.Poly exposing (buildrect)
import Lib.Map.Zhongyuan exposing (buildzystick)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildrect ( 0, 69 ) ( 120, 1 ) 2
        |> buildrect ( 0, 40 ) ( 14, 35 ) 2
        |> buildzystick ( 13, 45 )
