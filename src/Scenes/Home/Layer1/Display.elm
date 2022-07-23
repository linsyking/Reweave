module Scenes.Home.Layer1.Display exposing (dview)

{-| This is the doc for this module

@docs dview

-}

import Base exposing (..)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Constants exposing (..)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (renderText)
import Scenes.Home.Layer1.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


{-| dview
-}
dview : ( ModelX, Int ) -> CommonData -> GlobalData -> Renderable
dview ( m, _ ) _ gd =
    group []
        [ renderText gd 50 m.start.description "sans-serif" m.start.pos
        , renderText gd 50 m.help.description "sans-serif" m.help.pos
        , renderText gd 50 m.map.description "sans-serif" m.map.pos
        ]
