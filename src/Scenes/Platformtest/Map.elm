module Scenes.Platformtest.Map exposing (..)

{-| This is the doc for this module

@docs sds

@docs mymap

-}

import Array2D
import Lib.Map.Beimin exposing (buildbmleaf, buildbmlongground, buildbmlotus)
import Lib.Map.Donghai exposing (builddhbigrock, builddhrock, builddhsmallrock)
import Lib.Map.Jiangnan exposing (buildjnleaf, buildlongroof, buildroofleft, buildroofright)
import Lib.Map.Longxi exposing (buildlxlongground, buildlxplain, buildlxrock)
import Lib.Map.Poly exposing (buildrect)
import Lib.Map.Zhongyuan exposing (buildplatforms, buildzystick)


{-| sds
-}
sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 1
        |> buildrect ( 0, 60 ) ( 120, 2 ) 1
        |> buildrect ( 7, 53 ) ( 2, 2 ) 1
        |> buildrect ( 13, 53 ) ( 2, 2 ) 2
        |> buildrect ( 19, 53 ) ( 2, 2 ) 1
        |> buildbmlongground ( 25, 60 )
        |> buildbmlotus ( 29, 53 )
        |> buildbmleaf ( 35, 53 )
        |> builddhsmallrock ( 41, 53 )
        |> builddhrock ( 46, 53 )
        |> builddhbigrock ( 52, 45 )
        |> buildroofleft ( 58, 53 )
        |> buildroofright ( 64, 53 )
        |> buildlongroof ( 70, 55 ) 5
        |> buildjnleaf ( 95, 55 )
        |> buildlxrock ( 100, 55 )
        |> buildlxplain ( 105, 55 )
        |> buildlxlongground ( 60, 60 ) 3
        |> buildzystick ( 90, 50 )
        |> buildplatforms ( 90, 60 ) 4
