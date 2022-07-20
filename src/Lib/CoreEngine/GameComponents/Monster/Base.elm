module Lib.CoreEngine.GameComponents.Monster.Base exposing (..)


type alias MonsterInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , uid : Int
    }
