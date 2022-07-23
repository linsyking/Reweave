module Scenes.Home.Layer1.Common exposing
    ( Button
    , ModelX
    )

{-| This is the doc for this module

@docs Button

@docs ModelX

-}

import Base exposing (..)


{-| Button
-}
type alias Button =
    { description : String
    , pos : ( Int, Int )
    , length : Int
    , width : Int
    }


{-| ModelX
-}
type alias ModelX =
    { start : Button
    }
