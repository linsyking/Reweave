module Lib.CoreEngine.BackgroundLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Render.Render exposing (renderSprite)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( _, _ ) _ gd =
    renderSprite gd [ alpha 0.3 ] ( 0, 0 ) ( 1920, 1080 ) "background" gd.sprites
