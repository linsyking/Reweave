module Scenes.Level2.Map exposing
    ( sds
    , mymap
    )

{-| This is the doc for this module

@docs sds

@docs mymap

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)


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
