module Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)

{-| This is the doc for this module

@docs ExitInit

-}

import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition)


{-| ExitInit
-}
type alias ExitInit =
    { initPosition : ( Int, Int )
    , togo : String
    , newPlayerPosition : PlayerInitPosition
    , newState : Int
    , uid : Int
    }
