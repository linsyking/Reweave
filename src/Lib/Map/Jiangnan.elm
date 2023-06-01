module Lib.Map.Jiangnan exposing
    ( buildroofright
    , buildroofleft
    , buildroofmiddle
    , buildlongroof
    , buildjnleaf
    )

{-| This is the doc for this module

@docs buildroofright

@docs buildroofleft

@docs buildroofmiddle

@docs buildlongroof

@docs buildjnleaf

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)
import List exposing (foldl)


{-| buildroofright
-}
buildroofright : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildroofright ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 10
        |> buildrect ( x + 1, y ) ( 1, 1 ) 2


{-| buildroofleft
-}
buildroofleft : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildroofleft ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 11
        |> buildrect ( x + 1, y ) ( 1, 1 ) 2


{-| buildroofmiddle
-}
buildroofmiddle : ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildroofmiddle ( x, y ) mn ss =
    foldl
        (\i sc ->
            sc
                |> buildrect ( x + 3 * i, y ) ( 1, 1 ) 12
                |> buildrect ( x + 3 * i + 1, y ) ( 1, 1 ) 2
        )
        ss
        (List.range 0 (mn - 1))


{-| buildlongroof
-}
buildlongroof : ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildlongroof ( x, y ) mn ss =
    ss
        |> buildroofleft ( x, y )
        |> buildroofright ( x + 3 * (mn + 1), y )
        |> buildroofmiddle ( x + 3, y ) mn


{-| buildjnleaf
-}
buildjnleaf : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildjnleaf ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 13
