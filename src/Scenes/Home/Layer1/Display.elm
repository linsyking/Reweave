module Scenes.Home.Layer1.Display exposing (dview)

{-| This is the doc for this module

@docs dview

-}

import Base exposing (..)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..), Shadow, shadow)
import Canvas.Settings.Text exposing (TextAlign(..))
import Color
import Constants exposing (..)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (renderText, renderTextWithColor)
import Scenes.Home.Layer1.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


{-| dview
-}
dview : ( ModelX, Int ) -> CommonData -> GlobalData -> Renderable
dview ( m, _ ) _ gd =
    group [ shadow (Shadow 4 Color.red ( 5, 5 )) ]
        [ renderTextWithColor gd 80 m.start.description "Times New Roman" Color.black m.start.pos
        ]
