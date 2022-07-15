module Lib.CoreEngine.GameComponents.Goomba.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.Render.Render exposing (renderSprite, renderText)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( d, t ) ggd gd =
    group []
        [ renderSprite gd
            [ alpha
                (if ggd.selectobj == d.uid then
                    1

                 else
                    0.5
                )
            ]
            (getPositionUnderCamera d.position ggd)
            ( d.simplecheck.width, d.simplecheck.height )
            "background"
            gd.sprites
        , renderText gd 20 (String.fromFloat (Tuple.first d.velocity)) "sans-serif" (getPositionUnderCamera d.position ggd)
        ]
