module Lib.CoreEngine.BackgroundLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.Base exposing (GameGlobalData)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, t ) ggd gd =
    group []
        [ model.render t ggd gd
        ]



-- renderSprite gd [ alpha 0.3 ] ( 0, 0 ) ( 1920, 1080 ) "background" gd.sprites
