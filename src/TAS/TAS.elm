module TAS.TAS exposing
    ( startFrame
    , enableTAS, Key(..), Input(..), tas
    )

{-|


# TAS

TAS Module

@docs startFrame
@docs enableTAS, Key, Input, tas

-}


{-| The frame to starts with
-}
startFrame : Int
startFrame =
    0


{-| enable TAS flag
-}
enableTAS : Bool
enableTAS =
    True


{-| Keys
-}
type Key
    = A
    | D
    | C
    | W
    | E


{-| Input
-}
type Input
    = Down Key
    | Up Key
    | MouseLeft ( Int, Int )
    | MouseRright ( Int, Int )


{-| A Sample TAS
-}
tas : List ( Int, List Input )
tas =
    [ ( 1, [ MouseLeft ( 0, 0 ) ] )
    , ( 2, [ MouseLeft ( 890, 920 ) ] )
    , ( 3, [ Down D ] )
    , ( 18, [ MouseRright ( 1920, 1000 ), Down C, Down W, Up C ] )
    , ( 19, [ MouseRright ( 1920, 1000 ), Down C, Down W, Up C ] )
    , ( 33, [ MouseRright ( 1900, 0 ) ] )
    , ( 34, [ Down C ] )
    , ( 63, [ Up C, Down W ] )
    , ( 74, [ Down C ] )
    , ( 85, [ Up C, Up W ] )
    , ( 116, [ MouseRright ( 1920, 700 ), Down C, Down W, Up C ] )
    , ( 131, [ MouseRright ( 1920, 700 ), Down C, Down W, Up C ] )
    , ( 146, [ MouseRright ( 1920, 91 ) ] )
    , ( 195, [ Up C, Down W ] )
    , ( 233, [ MouseRright ( 1420, 0 ), Down C ] )
    , ( 243, [ Up C ] )
    , ( 263, [ Down C ] )
    , ( 334, [ Down W ] )
    , ( 335, [ MouseRright ( 800, 0 ) ] )
    , ( 373, [ Up C, Down W ] )
    , ( 385, [ MouseRright ( 1920, 419 ), Down C ] )
    , ( 447, [ Up C ] )
    , ( 471, [ MouseRright ( 1920, 300 ), Down C ] )
    , ( 493, [ Up C ] )
    , ( 566, [ Down W ] )
    ]
