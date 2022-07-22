module Lib.Map.Longxi exposing
    ( buildlxrock
    , buildlxplain
    , bulidlxgroundright
    , bulidlxgroundleft
    , buildlxgroundmiddle
    , buildlxlongground
    )

{-| This is the doc for this module

@docs buildlxrock

@docs buildlxplain

@docs bulidlxgroundright

@docs bulidlxgroundleft

@docs buildlxgroundmiddle

@docs buildlxlongground

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)
import List exposing (foldl)


{-| buildlxrock
-}
buildlxrock : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildlxrock ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 14


{-| buildlxplain
-}
buildlxplain : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildlxplain ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 15
        |> buildrect ( x + 1, y ) ( 1, 1 ) 2


{-| bulidlxgroundright
-}
bulidlxgroundright : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
bulidlxgroundright ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 16
        |> buildrect ( x + 1, y ) ( 7, 1 ) 2


{-| bulidlxgroundleft
-}
bulidlxgroundleft : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
bulidlxgroundleft ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 17
        |> buildrect ( x + 1, y ) ( 7, 1 ) 2


{-| buildlxgroundmiddle
-}
buildlxgroundmiddle : ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildlxgroundmiddle ( x, y ) mn ss =
    foldl
        (\i sc ->
            sc
                |> buildrect ( x + 2 * i, y ) ( 1, 1 ) 18
                |> buildrect ( x + 2 * i + 1, y ) ( 1, 1 ) 2
        )
        ss
        (List.range 0 (mn - 1))


{-| buildlxlongground
-}
buildlxlongground : ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildlxlongground ( x, y ) mn ss =
    ss
        |> bulidlxgroundleft ( x, y )
        |> bulidlxgroundright ( x + 8 + 2 * mn, y )
        |> buildlxgroundmiddle ( x + 8, y ) mn
