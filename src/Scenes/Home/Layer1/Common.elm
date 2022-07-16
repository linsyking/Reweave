module Scenes.Home.Layer1.Common exposing (..)

import Base exposing (..)


type alias Button =
    { description : String
    , pos : ( Int, Int )
    , width : Int
    , height : Int
    }

type alias ModelX =
    { ico : Int
    , start : Button
    , help : Button
    , map : Button
    }
