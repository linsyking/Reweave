module Lib.CoreEngine.FrontgroundLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, rect, shapes)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGloablData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)


view : ( Model, Int ) -> GameGloablData -> GlobalData -> Renderable
view ( _, _ ) _ _ =
    shapes [ alpha 0.3 ] [ rect ( 0, 0 ) 200 100 ]
