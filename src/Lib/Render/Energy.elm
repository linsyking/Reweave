module Lib.Render.Energy exposing (renderEnergyPoint)

{-| This is the doc for this module

@docs renderEnergyPoint

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.Render.Render exposing (renderSprite)


{-| renderEnergyPoint
-}
renderEnergyPoint : Int -> GlobalData -> Float -> ( ( Int, Int ), ( Int, Int ) ) -> Renderable
renderEnergyPoint t gd energy ( ( px, py ), ( px2, py2 ) ) =
    let
        ( cx, cy ) =
            ( (toFloat px + toFloat px2) / 2, (toFloat py + toFloat py2) / 2 )

        sta =
            modBy 80 t - 40
    in
    if energy < 300 then
        let
            pichalfsize =
                20

            ( stx, sty ) =
                ( floor (cx - pichalfsize), floor (cy - pichalfsize) )
        in
        renderSprite gd
            [ alpha
                (1
                    + (if sta < 0 then
                        toFloat sta / 200

                       else
                        toFloat -sta / 200
                      )
                )
            ]
            ( stx, sty )
            ( pichalfsize * 2, pichalfsize * 2 )
            "whiteshadow"

    else
        let
            pichalfsize =
                50

            ( stx, sty ) =
                ( floor (cx - pichalfsize), floor (cy - pichalfsize) )
        in
        renderSprite gd
            [ alpha
                (0.5
                    + (if sta < 0 then
                        toFloat -sta / 200

                       else
                        toFloat sta / 200
                      )
                )
            ]
            ( stx, sty )
            ( pichalfsize * 2, pichalfsize * 2 )
            "blueshadow"
