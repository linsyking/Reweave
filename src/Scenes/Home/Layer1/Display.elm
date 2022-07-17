module Scenes.Home.Layer1.Display exposing (..)

import Base exposing (..)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Color
import Constants exposing (..)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Home.Layer1.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


dview : ( ModelX, Int ) -> CommonData -> GlobalData -> Renderable
dview ( m, _ ) _ gd =
    let
        x =
            Tuple.first m.start.pos

        y =
            Tuple.second m.start.pos

        l =
            m.start.length

        w =
            m.start.width
    in
    group []
        [ shapes [ fill Color.blue ]
            [ rect (posToReal gd m.start.pos) (widthToReal gd (2 * l)) (heightToReal gd (2 * w))
            , rect (posToReal gd ( x, y + 100 )) (widthToReal gd (2 * l)) (heightToReal gd (2 * w))
            , rect (posToReal gd ( x, y + 200 )) (widthToReal gd (2 * l)) (heightToReal gd (2 * w))
            ]
        , renderText gd 50 m.start.description "sans-serif" m.start.pos
        , renderText gd 50 m.help.description "sans-serif" m.help.pos
        , renderText gd 50 m.map.description "sans-serif" m.map.pos
        ]
