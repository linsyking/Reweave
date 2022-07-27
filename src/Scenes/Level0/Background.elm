module Scenes.Level0.Background exposing (background)

{-| This is the doc for this module

@docs background

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.BackgroundLayer.ImageRolling exposing (genBackground)
import Lib.CoreEngine.Base exposing (GameGlobalData)


{-| background
-}
background : Int -> GameGlobalData -> GlobalData -> Renderable
background _ ggd gd =
    genBackground 0.125 0.7 "bg/bm" ggd gd
