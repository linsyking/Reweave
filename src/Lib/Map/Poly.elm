module Lib.Map.Poly exposing
    ( buildrect
    , buildPillar
    )

{-| This is the doc for this module

@docs buildrect

@docs buildPillar

-}

import Array2D


{-| buildrect
-}
buildrect : ( Int, Int ) -> ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildrect ( x, y ) ( w, h ) v ss =
    let
        xs =
            List.range x (x + w - 1)

        ys =
            List.range y (y + h - 1)
    in
    List.foldl
        (\i arr ->
            List.foldl
                (\j arr2 ->
                    Array2D.set i j v arr2
                )
                arr
                ys
        )
        ss
        xs


{-| buildPillar
-}
buildPillar : ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildPillar ( x, y ) n ss =
    List.foldl
        (\i sc ->
            sc
                |> buildrect ( x, y + 5 * i ) ( 1, 1 ) 21
                |> buildrect ( x, y + 5 * i + 1 ) ( 1, 4 ) 2
        )
        ss
        (List.range 0 (n - 1))
