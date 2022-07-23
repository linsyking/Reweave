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
    280


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
        |> buildplatforms ( 85, 60 ) 11
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
        |> buildlxrock ( 117, 59 )
        |> buildlxrock ( 125, 59 )
        |> buildzystick ( 127, 53 )
        |> buildplatforms ( 133, 66 ) 8
        |> buildplatforms ( 164, 25 ) 29
        |> buildPillar ( 165, 25 ) 8
