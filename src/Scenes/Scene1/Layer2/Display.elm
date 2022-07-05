module Scenes.Scene1.Layer2.Display exposing (..)

import Array
import Base exposing (..)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Color
import Lib.Component.ComponentHandler exposing (genView)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Scene1.Layer2.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


dview : SModel -> CommonData -> GlobalData -> Renderable
dview ( model, t ) _ gd =
    genView gd t (Array.fromList model.components)
