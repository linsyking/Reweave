module Lib.CoreEngine.GameLayer.Display exposing (..)

import Array
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (genView)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.Render.Chartlet exposing (renderChartletsBehindActor, renderChartletsBehindSolids, renderChartletsFront)
import Lib.Render.Solid exposing (renderSolids)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, ot ) ggd gd =
    let
        allobjs =
            Array.push model.player model.actors

        t =
            if ggd.ingamepause then
                0

            else
                ot
    in
    group []
        [ renderChartletsBehindActor model ggd gd
        , genView ggd gd t allobjs
        , renderChartletsBehindSolids model ggd gd
        , renderSolids ggd gd
        , renderChartletsFront model ggd gd
        ]
