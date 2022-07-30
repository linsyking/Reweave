module Scenes.End.Map exposing
    ( mymap
    , mapwidth
    )

{-| This is the doc for this module

@docs mymap
@docs mapwidth

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)
import Lib.Map.Zhongyuan exposing (buildplatforms)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat mapwidth 70 0


{-| mapwidth
-}
mapwidth : Int
mapwidth =
    300


{-| mymap
-}
mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 2
        |> buildplatforms ( 0, 68 ) 80
        |> buildrect ( 0, 69 ) ( mapwidth, 1 ) 2
        |> buildrect ( mapwidth - 1, 0 ) ( 1, 70 ) 2
