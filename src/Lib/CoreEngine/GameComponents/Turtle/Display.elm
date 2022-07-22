module Lib.CoreEngine.GameComponents.Turtle.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (alpha, rotate, transform)
import Color
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Lib.DefinedTypes.Parser exposing (dgetint)
import Lib.Render.Render exposing (renderSprite, renderSpriteWithRev)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        ( vx, _ ) =
            d.velocity

        hp =
            dgetint d.extra "Life"

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
                ]
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                "turtle"
            ]
      , 0
      )
    , ( group []
            (List.map
                (\( ( p1x, p1y ), ( p2x, p2y ) ) ->
                    renderSprite
                        gd
                        [ alpha 0.4
                        ]
                        (getPositionUnderCamera ( p1x, p1y ) ggd)
                        ( p2x - p1x, p2y - p1y )
                        "background"
                )
                cboxs
            )
      , 0
      )
    , viewbar hp d ggd gd
    ]


viewbar : Int -> Data -> GameGlobalData -> GlobalData -> ( Renderable, Int )
viewbar hp d ggd gd =
    let
        ( px, py ) =
            d.position

        health =
            floor ((toFloat hp / 2000) * 500)
    in
    ( group []
        [ shapes [ fill Color.red ]
            [ rect (posToReal gd (getPositionUnderCamera ( px + 30, py + 520 ) ggd)) (widthToReal gd health) (heightToReal gd 10)
            ]
        , shapes [ fill Color.grey ]
            [ rect (posToReal gd (getPositionUnderCamera ( px + 30 + health, py + 520 ) ggd)) (widthToReal gd (500 - health)) (heightToReal gd 10)
            ]
        ]
    , 1
    )
