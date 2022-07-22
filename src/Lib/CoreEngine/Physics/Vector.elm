module Lib.CoreEngine.Physics.Vector exposing
    ( addIntVec
    , addFloatVec
    )

{-| This is the doc for this module

@docs addIntVec

@docs addFloatVec

-}


{-| addIntVec
-}
addIntVec : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
addIntVec ( a, b ) ( c, d ) =
    ( a + c, b + d )


{-| addFloatVec
-}
addFloatVec : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
addFloatVec ( a, b ) ( c, d ) =
    ( a + c, b + d )
