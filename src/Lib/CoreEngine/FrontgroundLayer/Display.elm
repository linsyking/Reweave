module Lib.CoreEngine.FrontgroundLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.Component.ComponentHandler exposing (genView)
import Lib.Coordinate.Coordinates exposing (heightToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.Render.Render exposing (renderText)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, t ) ggd gd =
    group []
        [ shapes [ alpha 0.3 ] [ rect ( 0, 0 ) (widthToReal gd 200) (heightToReal gd 100) ]
        , if ggd.selectobj > 0 then
            renderText gd 20 ("Selected:" ++ String.fromInt ggd.selectobj) "sans-serif" ( 10, 10 )

          else
            group [] []
        , renderText gd 20 ("Energy:" ++ String.fromFloat ggd.energy) "sans-serif" ( 10, 40 )
        , genView gd t model.components
        , model.render t ggd gd
        ]
