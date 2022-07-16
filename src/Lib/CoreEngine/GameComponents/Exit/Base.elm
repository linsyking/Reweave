module Lib.CoreEngine.GameComponents.Exit.Base exposing (..)


type alias ExitInit =
    { initPosition : ( Int, Int )
    , initSize : ( Int, Int )
    , togo : String
    , uid : Int
    }
