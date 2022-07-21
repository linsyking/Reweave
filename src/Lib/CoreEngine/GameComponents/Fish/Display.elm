module Lib.CoreEngine.GameComponents.Fish.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha, rotate, transform)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.Render.Render exposing (renderSprite, renderText)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    [ ( group []
            [ renderSprite gd
                [ alpha
                    (if ggd.selectobj == d.uid then
                        1

                     else
                        0.5
                    )
                , transform
                    (case d.status of
                        Dead kd ->
                            [ rotate (degrees (toFloat (t - kd))) ]

                        _ ->
                            []
                    )
                ]
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                "fish"
            , renderText gd 20 (String.fromFloat (Tuple.first d.velocity)) "sans-serif" (getPositionUnderCamera d.position ggd)
            ]
      , 0
      )
    ]
