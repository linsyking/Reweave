module Lib.Map.Beimin exposing (..)

import Array2D
import Lib.Map.Poly exposing (buildrect)


buildbmground : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildbmground ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 3
        |> buildrect ( x + 1, y ) ( 4, 1 ) 2


buildbmlongground : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildbmlongground ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 4
        |> buildrect ( x + 1, y ) ( 19, 1 ) 2


buildbmlotus : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildbmlotus ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 5


buildbmleaf : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildbmleaf ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 6
        |> buildrect ( x + 1, y ) ( 2, 1 ) 2
