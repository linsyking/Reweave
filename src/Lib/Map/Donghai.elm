module Lib.Map.Donghai exposing (..)

import Array2D
import Lib.Map.Poly exposing (buildrect)


builddhsmallrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
builddhsmallrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 7


builddhrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
builddhrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 3, 2 ) 2
        |> buildrect ( x, y ) ( 1, 1 ) 8


builddhbigrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
builddhbigrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 4, 8 ) 2
        |> buildrect ( x, y ) ( 1, 1 ) 9
