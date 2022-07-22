module Lib.Map.Poly exposing (buildrect)

{-| This is the doc for this module

@docs buildrect

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
