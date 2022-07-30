module Lib.Map.Donghai exposing
    ( builddhsmallrock
    , builddhrock
    , builddhbigrock
    )

{-| This is the doc for this module

@docs builddhsmallrock

@docs builddhrock

@docs builddhbigrock

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)


{-| builddhsmallrock
-}
builddhsmallrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
builddhsmallrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 7


{-| builddhrock
-}
builddhrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
builddhrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 3, 2 ) 2
        |> buildrect ( x, y ) ( 1, 1 ) 8


{-| builddhbigrock
-}
builddhbigrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
builddhbigrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 4, 8 ) 2
        |> buildrect ( x, y ) ( 1, 1 ) 9
