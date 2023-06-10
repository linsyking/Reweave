module TAS.TAS exposing (enableTAS, Key(..), Input(..), tas)

{-|


# TAS

TAS Module

@docs enableTAS, Key, Input, tas

-}


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
tas : List ( Int, Input )
tas =
    [ ( 1, MouseLeft ( 0, 0 ) )
    ]
