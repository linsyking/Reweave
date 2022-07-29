module Scenes.Path.Map exposing (mymap)

{-| This is the doc for this module

@docs mymap

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)
import Lib.Map.Zhongyuan exposing (buildplatforms)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 62 70 0


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildplatforms ( 0, 68 ) 15
        |> buildrect ( 0, 69 ) ( 61, 1 ) 2
        |> buildrect ( 61, 0 ) ( 1, 70 ) 2
