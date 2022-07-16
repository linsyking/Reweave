module Scenes.Home.Layer1.Display exposing (..)

import Base exposing (..)
import Constants exposing (..)
import Lib.Coordinate.Coordinates exposing (..)
import Scenes.Home.Layer1.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Lib.Render.Render exposing (renderSprite, renderText)
import Color

dview : ( ModelX, Int ) -> CommonData -> GlobalData -> Renderable
dview ( m, _ ) _ gd =
    let
        x = Tuple.first m.start.pos
        y = Tuple.second m.start.pos
        w = m.start.width
        h = m.start.height
    in
    
    group []
        [ shapes [ fill Color.blue ] 
            [ rect (posToReal gd m.start.pos) (widthToReal gd (2 * w)) (heightToReal gd (2 * h)) 
            , rect (posToReal gd ( x, y + 100 )) (widthToReal gd (2 * w)) (heightToReal gd (2 * h)) 
            , rect (posToReal gd ( x, y + 200 )) (widthToReal gd (2 * w)) (heightToReal gd (2 * h)) 
            ]
        , renderText gd 50 m.start.description "sans-serif" m.start.pos
        , renderText gd 50 m.help.description "sans-serif" m.help.pos
        , renderText gd 50 m.map.description "sans-serif" m.map.pos
        ]
