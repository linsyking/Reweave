module Lib.Map.Chartlet exposing (..)

import Array2D
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Tools.Math exposing (rfint)


renderBackgroundChartletsFromSolid : GameGlobalData -> GlobalData -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
renderBackgroundChartletsFromSolid ggd gd =
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
                                        subs ++ renderSingleBlock v ( brickSize * i, brickSize * j ) ggd gd

                                Nothing ->
                                    subs
                        )
                        alls
                        jr
                )
                []
                ir
    in
    sls


renderSingleBlock : Int -> ( Int, Int ) -> GameGlobalData -> GlobalData -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
renderSingleBlock _ _ _ _ =
    [ ( \_ _ -> group [] [], BehindActors ) ]
