module Scenes.Level5boss.Map exposing (mymap)

{-| This is the doc for this module

@docs mymap

-}

import Array2D
import Lib.Map.Jiangnan exposing (buildlongroof)
import Lib.Map.Poly exposing (buildPillar, buildrect)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 100 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildrect ( 0, 69 ) ( 100, 1 ) 2
        |> buildlongroof ( 0, 60 ) 9
        |> buildPillar ( 25, 0 ) 11
        |> buildPillar ( 31, 61 ) 2
        |> buildlongroof ( 42, 67 ) 16
        |> buildlongroof ( 30, 45 ) 0
        |> buildlongroof ( 87, 45 ) 0
        |> buildlongroof ( 60, 25 ) 0
