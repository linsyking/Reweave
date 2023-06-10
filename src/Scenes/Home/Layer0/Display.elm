module Scenes.Home.Layer0.Display exposing (dview)

{-| This is the doc for this module

@docs dview

-}

import Base exposing (..)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Home.Layer0.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


{-| dview
-}
dview : ( ModelX, Int ) -> CommonData -> GlobalData -> Renderable
dview ( _, _ ) _ gd =
    group []
        [ renderSprite gd [] ( 0, 0 ) ( 1920, 1080 ) "homepage"
        , renderText gd 30 "1.0.2" "Courier New" ( 1750, 1000 )
        ]
