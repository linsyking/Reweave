module Scenes.Level1.Map exposing
    ( sds
    , mymap
    )

{-| This is the doc for this module

@docs sds

@docs mymap

-}

import Array2D
import Lib.Map.Beimin exposing (buildbmleaf, buildbmlotus)
import Lib.Map.Donghai exposing (builddhsmallrock)
import Lib.Map.Poly exposing (buildrect)
import Lib.Map.Zhongyuan exposing (buildzystick)


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
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildrect ( 0, 69 ) ( 120, 1 ) 2
        |> buildrect ( 0, 40 ) ( 14, 35 ) 2
        |> buildzystick ( 13, 45 )
        |> buildbmleaf ( 30, 65 )
        |> buildbmleaf ( 55, 42 )
        |> buildrect ( 45, 60 ) ( 1, 10 ) 1
        |> buildbmlotus ( 70, 65 )
        |> buildbmlotus ( 68, 65 )
        |> buildbmlotus ( 72, 65 )
        |> buildrect ( 80, 64 ) ( 1, 10 ) 1
        |> buildrect ( 90, 60 ) ( 1, 10 ) 1
        |> buildrect ( 101, 50 ) ( 1, 20 ) 1
        |> buildrect ( 110, 47 ) ( 10, 30 ) 2
        |> buildzystick ( 105, 64 )
        |> builddhsmallrock ( 104, 63 )
