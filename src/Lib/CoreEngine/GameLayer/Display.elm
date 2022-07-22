module Lib.CoreEngine.GameLayer.Display exposing (..)

{-| This is the doc for this module

@docs view

-}

import Array
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (alpha)
import Color exposing (black)
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (genView)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.CoreEngine.GameLayer.Common exposing (Model, kineticCalc, searchUIDGC)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Lib.Render.Chartlet exposing (renderChartletsBehindActor, renderChartletsBehindSolids, renderChartletsFront)
import Lib.Render.Energy exposing (renderEnergyPoint)
import Lib.Render.Render exposing (renderText)
import Lib.Render.Solid exposing (renderSolids)


{-| view
-}
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

        selected =
            ggd.selectobj

        ( px, py ) =
            model.player.data.position
    in
    group []
        [ renderText gd 30 ("x:" ++ String.fromInt px ++ ", y:" ++ String.fromInt py) "Times New Roman" ( 200, 0 )
        , renderChartletsBehindActor model ggd gd
        , genView ggd gd t allobjs
        , if selected > 0 then
            let
                obj =
                    searchUIDGC selected allobjs
            in
            case Array.get obj allobjs of
                Just tk ->
                    let
                        ( p1, p2 ) =
                            getBoxPos tk.data.position tk.data.simplecheck
                    in
                    renderEnergyPoint t gd (kineticCalc tk.data.mass tk.data.velocity) ( getPositionUnderCamera p1 ggd, getPositionUnderCamera p2 ggd )

                _ ->
                    group [] []

          else
            group [] []
        , renderChartletsBehindSolids model ggd gd
        , renderSolids ggd gd
        , renderChartletsFront model ggd gd
        , if ggd.ingamepause && ggd.settingpause then
            shapes [ fill black, alpha 0.5 ] [ rect (posToReal gd ( 0, 0 )) (widthToReal gd 1920) (heightToReal gd 1080) ]

          else
            group [] []
        ]
