module Lib.CoreEngine.GameComponents.Bullet.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.Render.Render exposing (renderSprite, renderText)
import Canvas exposing (shapes)
import Canvas exposing (circle)
import Color
import Lib.Coordinate.Coordinates exposing (posToReal)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        ( x, y ) =
            getPositionUnderCamera d.position ggd
    in
    if d.status == Alive then
        [ ( group []
                [ shapes [  ] [ circle ( posToReal gd (x,y) ) 15 ]
                ]
          , 0
          )
        ]

    else
        [ ( group [] [], 0 ) ]
