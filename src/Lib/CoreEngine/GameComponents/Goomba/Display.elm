module Lib.CoreEngine.GameComponents.Goomba.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (rotate, transform)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.Render.Render exposing (renderSpriteWithRev)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        ( vx, _ ) =
            d.velocity
    in
    [ ( group []
            [ renderSpriteWithRev (vx >= 0)
                gd
                [ transform
                    (case d.status of
                        Dead kd ->
                            [ rotate (degrees (toFloat (t - kd))) ]

                        _ ->
                            []
                    )
                ]
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                (case d.status of
                    Dead _ ->
                        "goombadie"

                    _ ->
                        "goomba"
                )
            ]
      , 0
      )
    ]
