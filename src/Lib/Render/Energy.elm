module Lib.Render.Energy exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.Render.Render exposing (renderSprite)


renderEnergyPoint : Int -> GlobalData -> Float -> ( ( Int, Int ), ( Int, Int ) ) -> Renderable
renderEnergyPoint t gd energy ( ( px, py ), ( px2, py2 ) ) =
    let
        ( cx, cy ) =
            ( (toFloat px + toFloat px2) / 2, (toFloat py + toFloat py2) / 2 )

        pichalfsize =
            20

        ( stx, sty ) =
            ( floor (cx - pichalfsize), floor (cy - pichalfsize) )

        sta =
            modBy 80 t - 40
    in
    if energy < 300 then
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
