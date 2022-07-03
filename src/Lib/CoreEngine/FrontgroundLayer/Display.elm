module Lib.CoreEngine.FrontgroundLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, rect, shapes)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.Coordinate.Coordinates exposing (heightToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( _, _ ) _ gd =
    shapes [ alpha 0.3 ] [ rect ( 0, 0 ) (widthToReal gd 200) (heightToReal gd 100) ]
