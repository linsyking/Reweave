module Scenes.Scene1.Layer1.Display exposing (..)

import Base exposing (..)
import Canvas exposing (Renderable, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Color
import Lib.Coordinate.Coordinates exposing (..)
import Scenes.Scene1.Layer1.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


dview : SModel -> CommonData -> GlobalData -> Renderable
dview ( _, _ ) _ gd =
    shapes [ fill Color.red ] [ rect (posToReal gd ( 0, 0 )) (widthToReal gd 1920) (heightToReal gd 1080) ]
