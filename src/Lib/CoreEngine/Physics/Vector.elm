module Lib.CoreEngine.Physics.Vector exposing (..)


addIntVec : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
addIntVec ( a, b ) ( c, d ) =
    ( a + c, b + d )


addFloatVec : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
addFloatVec ( a, b ) ( c, d ) =
    ( a + c, b + d )
