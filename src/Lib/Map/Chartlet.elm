module Lib.Map.Chartlet exposing
    ( renderBackgroundChartletsFromSolid
    , renderSingleBlock
    )

{-| This is the doc for this module

@docs renderBackgroundChartletsFromSolid

@docs renderSingleBlock

-}

import Array2D
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Lib.Tools.Math exposing (rfint)


{-| renderBackgroundChartletsFromSolid
-}
renderBackgroundChartletsFromSolid : GameGlobalData -> GlobalData -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
renderBackgroundChartletsFromSolid ggd _ =
    let
        allsolid =
            ggd.solidmap

        ( cx, cy ) =
            ggd.camera.position

        ( cx2, cy2 ) =
            ( cx + 1920, cy + 1080 )

        ( mw, mh ) =
            ggd.mapsize

        ir =
            List.range 0 mw

        jr =
            List.range 0 mh

        sls =
            List.foldl
                (\i alls ->
                    List.foldl
                        (\j subs ->
                            case Array2D.get i j allsolid of
                                Just v ->
                                    if v == 0 || v == 2 then
                                        subs

                                    else if v == 1 && (i < rfint cx || i > rfint cx2 || j < rfint cy || j > rfint cy2) then
                                        subs

                                    else
                                        subs ++ renderSingleBlock v ( brickSize * i, brickSize * j )

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



-- TODO:


{-| renderSingleBlock
-}
renderSingleBlock : Int -> ( Int, Int ) -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
renderSingleBlock tp p =
    case tp of
        5 ->
            -- Beimin lotus
            [ ( \gd ggd ->
                    let
                        ( cpx, cpy ) =
                            getPositionUnderCamera p ggd
                    in
                    renderSprite gd [] ( cpx - brickSize, cpy - 20 ) ( brickSize * 3, brickSize * 2 ) "bm/lotus"
              , BehindActors
              )
            ]

        6 ->
            -- Beimin leaf
            [ ( \gd ggd ->
                    let
                        ( cpx, cpy ) =
                            getPositionUnderCamera p ggd
                    in
                    renderSprite gd [] ( cpx - brickSize, cpy - 30 ) ( brickSize * 5, brickSize * 2 ) "bm/leaf"
              , BehindActors
              )
            ]

        13 ->
            -- jiangnan
            [ ( \gd ggd ->
                    let
                        ( cpx, cpy ) =
                            getPositionUnderCamera p ggd
                    in
                    renderSprite gd [] ( cpx - brickSize, cpy - 10 ) ( brickSize * 3, brickSize ) "jn/leaf"
              , BehindActors
              )
            ]

        15 ->
            -- lx plain
            [ ( \gd ggd ->
                    let
                        ( cpx, cpy ) =
                            getPositionUnderCamera p ggd
                    in
                    renderSprite gd [] ( cpx - brickSize, cpy - 10 ) ( brickSize * 4, brickSize ) "lx/plane"
              , BehindActors
              )
            ]

        20 ->
            -- zy road
            [ ( \gd ggd ->
                    let
                        ( cpx, cpy ) =
                            getPositionUnderCamera p ggd
                    in
                    renderSprite gd [] ( cpx, cpy - 15 ) ( brickSize * 6, brickSize ) "zy/platform"
              , BehindActors
              )
            ]

        _ ->
            []
