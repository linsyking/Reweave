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
    , ( 3, [ Down D, MouseRright ( 1920, 0 ), Down C ] )
    , ( 50, [ MouseRright ( 1920, 0 ) ] )
    ]
