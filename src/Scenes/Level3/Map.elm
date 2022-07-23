module Scenes.Level3.Map exposing
    ( sds
    , mymap
    )

{-| This is the doc for this module

@docs sds

@docs mymap

-}

import Array2D
import Lib.Map.Longxi exposing (buildlxlongground, buildlxrock, buildlxplain)
import Lib.Map.Poly exposing (buildPillar, buildrect)
import Lib.Map.Zhongyuan exposing (buildplatforms, buildzystick)


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
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildplatforms ( 1, 68 ) 30
        |> buildlxrock ( 38, 67 )
        |> buildzystick ( 44, 58 )
        |> buildzystick ( 55, 48 )
        |> buildzystick ( 50, 48 )
        |> buildlxrock ( 49, 47 )
        |> buildlxrock ( 60, 47 )
        |> buildzystick ( 62, 53 )
        |> buildzystick ( 67, 53 )
        |> buildlxrock ( 25, 67 )
        |> buildlxrock ( 25, 66 )
        |> buildrect ( 50, 67 ) ( 1, 1 ) 2
        |> buildrect ( 89, 46 ) ( 14, 22 ) 2
        |> buildlxrock ( 110, 60 )
        |> buildlxrock ( 115, 55 )
        |> buildlxrock ( 116, 54 )
        |> buildplatforms ( 117, 54 ) 10

        
