module Lib.Render.Solid exposing
    ( renderSolids
    , renderSingleBlock
    )

{-| This is the doc for this module

This module is used to render solid objects

@docs renderSolids

@docs renderSingleBlock

-}

import Array2D
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (rotate, transform)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.Render.Render exposing (renderSprite, renderSpriteWithRev)
import Lib.Tools.Math exposing (rfint)


{-| renderSolids
-}
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
            List.range (rfint cx - 10) (rfint cx2 + 10)

        jr =
            List.range (rfint cy - 10) (rfint cy2 + 10)

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


{-| renderSingleBlock
-}
renderSingleBlock : Int -> ( Int, Int ) -> GameGlobalData -> GlobalData -> Renderable
renderSingleBlock tp p ggd gd =
    let
        ( cpx, cpy ) =
            getPositionUnderCamera p ggd
    in
    case tp of
        1 ->
            -- shapes [ fill Color.red ] [ rect (posToReal gd (getPositionUnderCamera p ggd)) (widthToReal gd brickSize) (heightToReal gd brickSize) ]
            renderSprite gd [] ( cpx, cpy ) ( brickSize, brickSize ) "ot/block"

        3 ->
            -- beimin ground
            renderSprite gd [] ( cpx, cpy - 10 ) ( brickSize * 5, 0 ) "bm/ground"

        4 ->
            -- beimin long ground
            renderSprite gd [] ( cpx, cpy - 10 ) ( brickSize * 20, 10 ) "bm/ground"

        7 ->
            -- donghai smallrock
            renderSprite gd [] ( cpx - 15, cpy ) ( brickSize * 2, brickSize ) "dh/smallrock"

        8 ->
            -- donghai rock
            renderSprite gd [] ( cpx - 15, cpy ) ( brickSize * 4, brickSize * 2 ) "dh/rock"

        9 ->
            -- donghai bigrock
            renderSprite gd [] ( cpx - 15, cpy ) ( brickSize * 5, brickSize * 8 ) "dh/bigrock"

        10 ->
            -- jiangnan roofright
            renderSprite gd [] ( cpx - 15, cpy ) ( brickSize * 3, 0 ) "jn/roof"

        11 ->
            -- jiangnan roofleft
            renderSpriteWithRev True gd [] ( cpx - 15, cpy ) ( brickSize * 3, 0 ) "jn/roof"

        12 ->
            -- jiangnan roofmiddle
            renderSprite gd [] ( cpx - 15, cpy ) ( brickSize * 3, 0 ) "jn/PieceOfRoof"

        14 ->
            -- longxi rock
            renderSprite gd [] ( cpx - 15, cpy ) ( brickSize * 2, 0 ) "lx/rock"

        16 ->
            -- longxi ground
            renderSprite gd [] ( cpx - 3, cpy - 9 ) ( brickSize * 8, 0 ) "lx/ground"

        17 ->
            -- longxi ground
            renderSpriteWithRev True gd [] ( cpx, cpy - 9 ) ( brickSize * 8, 0 ) "lx/ground"

        18 ->
            -- longxi ground
            renderSprite gd [] ( cpx - 4, cpy + 5 - 9 ) ( brickSize * 2 + 4, 16 ) "lx/PieceOfGround"

        19 ->
            -- zhongyuan stick
            renderSprite gd [] ( cpx - 10, cpy ) ( brickSize * 6, 0 ) "zy/stick"

        21 ->
            -- pillar
            renderSprite gd [ transform [ rotate (degrees 90) ] ] ( cpx + 20, cpy - 10 ) ( brickSize * 6, 0 ) "zy/stick"

        _ ->
            group [] []
