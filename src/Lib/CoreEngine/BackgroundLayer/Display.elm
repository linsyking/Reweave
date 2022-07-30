module Lib.CoreEngine.BackgroundLayer.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (filter)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.Base exposing (GameGlobalData)


{-| view
-}
view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, t ) ggd gd =
    group
        (if ggd.ingamepause && ggd.settingpause then
            [ filter "blur(10px)" ]

         else
            []
        )
        [ model.render t ggd gd
        ]



-- renderSprite gd [ alpha 0.3 ] ( 0, 0 ) ( 1920, 1080 ) "background" gd.sprites
