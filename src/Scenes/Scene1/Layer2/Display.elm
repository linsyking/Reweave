module Scenes.Scene1.Layer2.Display exposing (..)

{-| This is the doc for this module

@docs dview

-}

import Array
import Base exposing (..)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..))
import Canvas.Settings.Text exposing (TextAlign(..))
import Lib.Component.ComponentHandler exposing (genView)
import Lib.Coordinate.Coordinates exposing (..)
import Scenes.Scene1.Layer2.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


{-| dview
-}
dview : SModel -> CommonData -> GlobalData -> Renderable
dview ( model, t ) _ gd =
    genView gd t (Array.fromList model.components)
