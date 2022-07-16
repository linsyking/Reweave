module Scenes.Home.Layer1.Common exposing (..)

import Base exposing (..)


type alias Button =
    { description : String
    , pos : ( Int, Int )
    , length : Int
    , width : Int
    }

type alias ModelX =
    { ico : Int
    , start : Button
    , help : Button
    , map : Button
    }
