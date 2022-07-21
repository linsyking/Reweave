module Scenes.TestChamber.Background exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Render.Render exposing (renderSprite)


background : Int -> GameGlobalData -> GlobalData -> Renderable
background _ _ gd =
    renderSprite gd [ alpha 0.3 ] ( 0, 0 ) ( 1920, 1080 ) "background"
