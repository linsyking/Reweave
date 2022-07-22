module Lib.CoreEngine.GameComponents.Exit.Base exposing (..)

import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition)


type alias ExitInit =
    { initPosition : ( Int, Int )
    , togo : String
    , newPlayerPosition : PlayerInitPosition
    , newState : Int
    , uid : Int
    }
