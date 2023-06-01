module Scenes.Level5.Map exposing
    ( mymap
    , mapsize
    )

{-| This is the doc for this module

@docs mymap

@docs mapsize

-}

import Array2D
import Lib.Map.Jiangnan exposing (buildjnleaf, buildlongroof)
import Lib.Map.Poly exposing (buildrect)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat mapsize 70 0


{-| mapsize
-}
mapsize : Int
mapsize =
    460


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildrect ( 0, 69 ) ( mapsize, 1 ) 2
        |> buildrect ( mapsize - 1, 0 ) ( 1, 70 ) 2
        |> buildrect ( 0, 63 ) ( 27, 5 ) 2
        |> buildrect ( 5, 61 ) ( 18, 1 ) 2
        |> buildrect ( 9, 59 ) ( 10, 2 ) 2
        |> buildlongroof ( 33, 60 ) 5
        |> buildlongroof ( 150, 60 ) 5
        |> buildjnleaf ( 175, 55 )
        |> buildjnleaf ( 182, 52 )
        |> buildjnleaf ( 185, 47 )
        |> buildlongroof ( 193, 43 ) 5
        |> buildlongroof ( 300, 50 ) 5
        |> buildlongroof ( 430, 55 ) 2
        |> buildlongroof ( 448, 52 ) 2
