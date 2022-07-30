module Scenes.Level4boss.Map exposing (mymap)

{-| This is the doc for this module

@docs mymap

-}

import Array2D
import Lib.Map.Donghai exposing (builddhrock)
import Lib.Map.Poly exposing (buildPillar, buildrect)
import Lib.Map.Zhongyuan exposing (buildzystick)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildrect ( 0, 69 ) ( 120, 1 ) 1
        -- |> buildrect ( 0, 40 ) ( 14, 35 ) 1
        |> builddhrock ( 10 + 25, 60 )
        |> builddhrock ( 18 + 25, 56 )
        |> builddhrock ( 30 + 25, 64 )
        |> builddhrock ( 33 + 25, 64 )
        |> builddhrock ( 36 + 25, 64 )
        |> builddhrock ( 39 + 25, 64 )
        |> builddhrock ( 42 + 25, 64 )
        |> builddhrock ( 53 + 25, 60 )
        |> buildzystick ( 25, 60 )
        |> buildzystick ( 19, 60 )
        |> buildzystick ( 13, 60 )
        |> buildzystick ( 7, 60 )
        |> buildzystick ( 1, 60 )
        |> buildPillar ( 19, 0 ) 11
        -- |> builddhrock ( 62, 55 )
        -- |> builddhrock ( 82, 40 )
        |> builddhrock ( 90, 30 )
        |> builddhrock ( 70, 55 )
        |> builddhrock ( 82, 60 )
        |> builddhrock ( 86, 60 )
        |> builddhrock ( 58, 55 )
        |> builddhrock ( 52, 45 )
        |> builddhrock ( 82, 50 )
        |> builddhrock ( 95, 45 )
        -- |> builddhrock ( 79, 40 )
        |> builddhrock ( 98, 30 )
        |> builddhrock ( 90, 10 )
        |> builddhrock ( 86, 10 )



-- |> builddhsmallrock (20, 40)
-- |> buildzystick ( 13, 45 )
-- |> buildbmleaf ( 30, 65 )
-- |> buildbmleaf ( 55, 42 )
-- |> buildrect ( 45, 60 ) ( 1, 10 ) 1
-- |> buildbmlotus ( 70, 65 )
-- |> buildbmlotus ( 68, 65 )
-- |> buildbmlotus ( 72, 65 )
-- |> buildrect ( 80, 64 ) ( 1, 10 ) 1
-- |> buildrect ( 90, 60 ) ( 1, 10 ) 1
-- |> buildPillar ( 101, 50 ) 5
-- |> buildrect ( 110, 47 ) ( 10, 30 ) 2
-- |> buildbmlotus ( 101, 49 )
-- |> buildbmlotus ( 99, 49 )
-- |> buildbmlotus ( 97, 48 )
-- |> buildbmlotus ( 103, 48 )
-- |> buildrect ( 119, 0 ) ( 1, 120 ) 2
