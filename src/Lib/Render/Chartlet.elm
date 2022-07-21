module Lib.Render.Chartlet exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.Map.Chartlet exposing (renderBackgroundChartletsFromSolid)


renderChartletsFront : Model -> GameGlobalData -> GlobalData -> Renderable
renderChartletsFront model ggd gd =
    group []
        (List.filterMap
            (\( x, dtype ) ->
                case dtype of
                    FrontSolids ->
                        Just (x gd ggd)

                    _ ->
                        Nothing
            )
            model.chartlets
        )


renderChartletsBehindActor : Model -> GameGlobalData -> GlobalData -> Renderable
renderChartletsBehindActor model ggd gd =
    group []
        (List.filterMap
            (\( x, dtype ) ->
                case dtype of
                    BehindActors ->
                        Just (x gd ggd)

                    _ ->
                        Nothing
            )
            (renderBackgroundChartletsFromSolid ggd gd ++ model.chartlets)
        )


renderChartletsBehindSolids : Model -> GameGlobalData -> GlobalData -> Renderable
renderChartletsBehindSolids model ggd gd =
    group []
        (List.filterMap
            (\( x, dtype ) ->
                case dtype of
                    BehindSolids ->
                        Just (x gd ggd)

                    _ ->
                        Nothing
            )
            model.chartlets
        )
