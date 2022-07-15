module Lib.CoreEngine.GameLayer.Display exposing (..)

import Array
import Array.Extra
import Array2D
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Color
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.CoreEngine.Physics.NaiveCollision exposing (judgeInCamera)
import Lib.Tools.Math exposing (rfint)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, t ) ggd gd =
    let
        allobjs =
            Array.push model.player model.actors
    in
    group []
        (Array.toList (Array.Extra.filterMap (\x -> renderSingleObject t x ggd gd) allobjs)
            ++ [ renderSolids ggd gd
               , renderChartlets model ggd gd
               ]
        )


renderSingleObject : Int -> GameComponent -> GameGlobalData -> GlobalData -> Maybe Renderable
renderSingleObject t gc ggd gd =
    if judgeInCamera gc ggd then
        -- Should show
        Just (gc.view ( gc.data, t ) ggd gd)

    else
        Nothing


renderSolids : GameGlobalData -> GlobalData -> Renderable
renderSolids ggd gd =
    let
        allsolid =
            ggd.solidmap

        ( cx, cy ) =
            ggd.camera.position

        ( cx2, cy2 ) =
            ( cx + 1920, cy + 1080 )

        ir =
            List.range (rfint cx) (rfint cx2 + 1)

        jr =
            List.range (rfint cy) (rfint cy2 + 1)

        sls =
            List.foldl
                (\i alls ->
                    List.foldl
                        (\j subs ->
                            case Array2D.get i j allsolid of
                                Just v ->
                                    if v == 0 then
                                        subs

                                    else
                                        subs ++ [ renderSingleBlock v ( brickSize * i, brickSize * j ) ggd gd ]

                                Nothing ->
                                    subs
                        )
                        alls
                        jr
                )
                []
                ir

        -- fds = Debug.log "sol" jr
    in
    group [] sls


renderSingleBlock : Int -> ( Int, Int ) -> GameGlobalData -> GlobalData -> Renderable
renderSingleBlock _ p ggd gd =
    shapes [ fill Color.red ] [ rect (posToReal gd (getPositionUnderCamera p ggd)) (widthToReal gd brickSize) (heightToReal gd brickSize) ]


renderChartlets : Model -> GameGlobalData -> GlobalData -> Renderable
renderChartlets model ggd gd =
    group [] (List.map (\x -> x gd ggd) model.chartlets)
