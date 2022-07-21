module Lib.Render.Solid exposing (..)

import Array2D
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Color
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.Render.Render exposing (renderBrickSheet)
import Lib.Tools.Math exposing (rfint)


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
                                    if v == 0 || v == 2 then
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
    in
    group [] sls


renderSingleBlock : Int -> ( Int, Int ) -> GameGlobalData -> GlobalData -> Renderable
renderSingleBlock tp p ggd gd =
    case tp of
        1 ->
            shapes [ fill Color.red ] [ rect (posToReal gd (getPositionUnderCamera p ggd)) (widthToReal gd brickSize) (heightToReal gd brickSize) ]

        k ->
            renderBrickSheet gd [] (getPositionUnderCamera p ggd) ( k, 3 ) "bricksheet" gd.sprites
