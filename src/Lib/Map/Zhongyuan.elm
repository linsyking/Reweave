module Lib.Map.Zhongyuan exposing
    ( buildzystick
    , buildplatforms
    )

{-| This is the doc for this module

@docs buildzystick

@docs buildplatforms

-}

import Array2D
import Lib.Map.Poly exposing (buildrect)
import List exposing (foldl)


{-| buildzystick
-}
buildzystick : ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildzystick ( x, y ) ss =
    ss
        |> buildrect ( x, y ) ( 1, 1 ) 19
        |> buildrect ( x + 1, y ) ( 4, 1 ) 2


{-| buildplatforms
-}
buildplatforms : ( Int, Int ) -> Int -> Array2D.Array2D Int -> Array2D.Array2D Int
buildplatforms ( x, y ) mn ss =
    foldl
        (\i sc ->
            sc
                |> buildrect ( x + 4 * i, y ) ( 1, 1 ) 20
                |> buildrect ( x + 4 * i + 1, y ) ( 5, 1 ) 2
        )
        ss
        (List.range 0 (mn - 1))
