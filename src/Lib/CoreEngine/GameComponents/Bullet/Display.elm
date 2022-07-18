module Lib.CoreEngine.GameComponents.Bullet.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, circle, group, shapes)
import Canvas.Settings exposing (fill)
import Color
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetfloat, dgetint)
import Lib.Render.Render exposing (renderSprite, renderText)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        r =
            dgetfloat d.extra "radius"

        x =
            toFloat (Tuple.first (getPositionUnderCamera d.position ggd))

        y =
            toFloat (Tuple.second (getPositionUnderCamera d.position ggd))
    in
    if d.status == Alive then
        [ ( group []
                [ renderSprite gd [] (getPositionUnderCamera d.position ggd) (d.simplecheck.width, 0) "bullet"
                ]
          , 0
          )
        ]

    else
        [ ( group [] [], 0 ) ]
