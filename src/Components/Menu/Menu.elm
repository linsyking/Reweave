module Components.Menu.Menu exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict exposing (Dict)
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..), dgetfloat, dsetfloat)
import Lib.Coordinate.Coordinates exposing (..)


initMenu : Int -> ComponentTMsg -> Data
initMenu _ _ =
    Dict.fromList
        [ ( "cx", CDFloat 120 ) -- center of circle
        , ( "cy", CDFloat 120 )
        , ( "radius", CDFloat 30 ) -- radius of circle
        , ( "cp1x", CDFloat 110 ) -- the first controlling point of bezier curve
        , ( "cp1y", CDFloat 28 )
        , ( "cp2x", CDFloat 112 ) -- the second controlling point of bezier curve
        , ( "cp2y", CDFloat 179 )
        , ( "t", CDFloat 0 ) -- duration
        , ( "clockwise", CDInt 0 ) -- 4 states of the curve
        , ( "angle", CDFloat -90 )
        ]


updateMenu : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMenu msg gMsg globalData ( d, t ) =
    let
        time =
            dgetfloat d "t"
    in
    case gMsg of
        ComponentIntMsg num ->
            ( d |> dsetfloat "angle" (90 - 180 / 100 * toFloat num), NullComponentMsg, globalData )

        _ ->
            ( d, NullComponentMsg, globalData )


viewMenu : ( Data, Int ) -> GlobalData -> Renderable
viewMenu ( d, _ ) globalData =
    let
        angle =
            dgetfloat d "angle"

        cx =
            dgetfloat d "cx"

        cy =
            dgetfloat d "cy"

        radius =
            dgetfloat d "radius"

        cp1x =
            dgetfloat d "cp1x"

        cp1y =
            dgetfloat d "cp1y"

        cp2x =
            dgetfloat d "cp2x"

        cp2y =
            dgetfloat d "cp2y"
    in
    if angle == -90 then
        group
            []
            [ Canvas.clear ( 0, 0 ) 400 400
            , shapes
                [ fill Color.green
                ]
                [ circle ( cx, cy ) radius
                ]
            , shapes
                [ stroke Color.darkGreen
                ]
                [ circle ( cx, cy ) (radius + 5)
                ]
            ]

    else
        let
            x =
                cx - radius * cos (degrees angle)

            y =
                cy + radius * sin (degrees angle)
        in
        group
            []
            [ Canvas.clear ( 0, 0 ) 400 400
            , shapes
                [ fill Color.green
                ]
                [ path ( x, y ) [ renderBezier angle cx cy radius cp1x cp1y cp2x cp2y ]
                , renderArc angle cx cy radius
                ]
            , shapes
                [ stroke Color.darkGreen
                ]
                [ circle ( cx, cy ) (radius + 5)
                ]
            ]


renderArc : Float -> Float -> Float -> Float -> Shape
renderArc angle cx cy radius =
    if angle > 0 then
        arc ( cx, cy ) radius { startAngle = degrees angle, endAngle = degrees 180 - degrees angle, clockwise = True }

    else
        arc ( cx, cy ) radius { endAngle = degrees 180 - degrees angle, startAngle = degrees 360 + degrees angle, clockwise = True }


renderBezier : Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> PathSegment
renderBezier angle cx cy radius cp1x cp1y cp2x cp2y =
    let
        x =
            cx + radius * cos (degrees angle)

        y =
            cy + radius * sin (degrees angle)
    in
    bezierCurveTo ( cp1x, cp1y ) ( cp2x, cp2y ) ( x, y )
