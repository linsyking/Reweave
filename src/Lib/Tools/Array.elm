module Lib.Tools.Array exposing (..)

import Array exposing (Array)


locate : (a -> Bool) -> Array a -> List Int
locate f xs =
    let
        b =
            List.range 0 (Array.length xs - 1)

        res =
            List.filter
                (\i ->
                    case Array.get i xs of
                        Just x ->
                            if f x then
                                True

                            else
                                False

                        Nothing ->
                            False
                )
                b
    in
    res
