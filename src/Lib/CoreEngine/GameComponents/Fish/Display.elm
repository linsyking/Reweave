module Lib.CoreEngine.GameComponents.Fish.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha, rotate, transform)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Lib.Render.Render exposing (renderSprite, renderSpriteWithRev)


{-| view
-}
view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        ( vx, _ ) =
            d.velocity

        isalive =
            case d.status of
                Dead _ ->
                    False

                _ ->
                    True

        cboxs =
            List.map (\x -> getBoxPos d.position x) d.collisionbox
    in
    [ ( group []
            [ renderSpriteWithRev (vx > 0)
                gd
                [ transform
                    (case d.status of
                        Dead kd ->
                            [ rotate (degrees (toFloat (t - kd))) ]

                        _ ->
                            []
                    )
                , alpha
                    (if isalive then
                        1

                     else
                        0.6
                    )
                ]
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                "fish"
            ]
      , 0
      )
    , ( group []
            (List.map
                (\( ( p1x, p1y ), ( p2x, p2y ) ) ->
                    renderSprite
                        gd
                        [ alpha 0
                        ]
                        (getPositionUnderCamera ( p1x, p1y ) ggd)
                        ( p2x - p1x, p2y - p1y )
                        "background"
                )
                cboxs
            )
      , 0
      )
    ]
