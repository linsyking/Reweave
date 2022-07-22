module Scenes.Scene1.Layer1.Display exposing (..)

{-| This is the doc for this module

@docs dview

-}

import Base exposing (..)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Color
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Energy exposing (renderEnergyPoint)
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Scene1.Layer1.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


{-| dview
-}
dview : SModel -> CommonData -> GlobalData -> Renderable
dview ( _, t ) _ gd =
    group []
        [ renderSprite gd [] ( 0, 0 ) ( 1920, 1080 ) "background"
        , shapes [ fill Color.red ] [ rect (posToReal gd ( 200, 100 )) (widthToReal gd 100) (heightToReal gd 200) ]
        , renderEnergyPoint t gd 1 ( ( 200, 100 ), ( 299, 299 ) )
        , renderText gd 50 "ohohoh" "sans-serif" ( 0, 50 )
        ]
