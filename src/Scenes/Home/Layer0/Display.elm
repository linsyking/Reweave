module Scenes.Home.Layer0.Display exposing (..)

import Base exposing (..)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Color
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Home.Layer0.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


dview : ( ModelX, Int ) -> CommonData -> GlobalData -> Renderable
dview ( _, _ ) _ gd =
    group []
        [ renderSprite gd [] ( 0, 0 ) ( 1920, 1080 ) "background" gd.sprites
        ]
