module Lib.Resources.Background exposing (findBackgroundImage)

{-| This is the doc for this module

@docs findBackgroundImage

-}


{-| findBackgroundImage
-}
findBackgroundImage : String -> String
findBackgroundImage s =
    case s of
        "Level0" ->
            "bg/bm"

        "Level1" ->
            "bg/bm"

        "Level2" ->
            "bg/lx"

        "Level3" ->
            "bg/zy"

        "Level4" ->
            "bg/jn"

        "Level5" ->
            "bg/dh"

        _ ->
            "bg/bm"
