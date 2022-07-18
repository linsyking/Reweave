module Lib.CoreEngine.GameComponents.Bullet.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.Render.Render exposing (renderSprite, renderText)
import Canvas exposing (shapes)
import Color
import Canvas exposing (circle)
import Lib.DefinedTypes.Parser exposing (dgetfloat, dgetint)
import Canvas.Settings exposing (fill)
import Lib.CoreEngine.GameComponent.Base exposing (LifeStatus(..))

view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        r = 
            dgetfloat d.extra "radius"
        
        x =
           toFloat ( Tuple.first (getPositionUnderCamera d.position ggd) )

        y =
            toFloat ( Tuple.second (getPositionUnderCamera d.position ggd) )
    in
    if d.status == Alive then
        [(group []
            [ shapes [ fill Color.red ] [ circle ( x, y ) r ]
            ]
        , 0)]
    else
        [(group [] [],0)]

