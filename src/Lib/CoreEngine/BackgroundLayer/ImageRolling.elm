module Lib.CoreEngine.BackgroundLayer.ImageRolling exposing (genBackground)

{-| This is the doc for this module

@docs genBackground

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Render.Render exposing (renderSprite)


{-| genBackground
This function generates the bakcground rolling effects according to the camera and the moving rate

The rate variable is how much the background moves right if the camera moves 1 unit

-}
genBackground : Float -> String -> GameGlobalData -> GlobalData -> Renderable
genBackground rate pic ggd gd =
    let
        ( cpx, _ ) =
            ggd.camera.position

        offsetx =
            toFloat cpx * rate
    in
    renderSprite gd [ alpha 0.7 ] ( floor -offsetx, 0 ) ( 0, 1080 ) pic
