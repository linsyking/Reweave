module Components.Bar.Bar exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetfloat, dsetfloat)


initBar : Int -> ComponentTMsg -> Data
initBar energy _ =
    let
        angle =
            90 - 180 / 100 * toFloat energy
    in
    Dict.fromList
        [ ( "cx", CDFloat 120 ) -- center of circle
        , ( "cy", CDFloat 120 )
        , ( "radius", CDFloat 50 ) -- radius of circle
        , ( "cp1x", CDFloat 110 ) -- the first controlling point of bezier curve
        , ( "cp1y", CDFloat 28 )
        , ( "cp2x", CDFloat 112 ) -- the second controlling point of bezier curve
        , ( "cp2y", CDFloat 179 )
        , ( "t", CDFloat 0 ) -- duration
        , ( "clockwise", CDInt 0 ) -- 4 states of the curve
        , ( "angle", CDFloat angle )
        ]


bezier : Int -> Float -> Data -> Data
bezier clockwise t d =
    let
        time =
            dgetfloat d "t"

        cx =
            dgetfloat d "cx"

        cy =
            dgetfloat d "cy"

        radius =
            dgetfloat d "radius"

        angle =
            dgetfloat d "angle"

        lineY =
            cy + radius * sin (degrees angle)

        k =
            (90 - abs angle) / 7

        m =
            radius * cos (degrees angle) / 8

        cp1x =
            cx - m + 20 * t

        cp1y =
            lineY - k + k * t

        cp2x =
            cx - m - 20 * t

        cp2y =
            lineY + k - k * t

        cp1CounterX =
            cx + 20 - m - 20 * t

        cp1CounterY =
            lineY - k * t

        cp2CounterX =
            cx - m - 20 + 20 * t

        cp2CounterY =
            lineY + k * t
    in
    case clockwise of
        1 ->
            d
                |> dsetfloat "cp1x" cp1x
                |> dsetfloat "cp1y" cp1y
                |> dsetfloat "cp2x" cp2x
                |> dsetfloat "cp2y" cp2y
                |> dsetfloat "t" (time + 0.01)

        0 ->
            d
                |> dsetfloat "cp1x" cp1CounterX
                |> dsetfloat "cp1y" cp1CounterY
                |> dsetfloat "cp2x" cp2CounterX
                |> dsetfloat "cp2y" cp2CounterY
                |> dsetfloat "t" (time + 0.01)

        2 ->
            d
                |> dsetfloat "cp1x" cp1CounterX
                |> dsetfloat "cp1y" (-cp1CounterY + 2 * lineY)
                |> dsetfloat "cp2x" cp2CounterX
                |> dsetfloat "cp2y" (-cp2CounterY + 2 * lineY)
                |> dsetfloat "t" (time + 0.01)

        3 ->
            d
                |> dsetfloat "cp1x" cp1x
                |> dsetfloat "cp1y" (-cp1y + 2 * lineY)
                |> dsetfloat "cp2x" cp2x
                |> dsetfloat "cp2y" (-cp2y + 2 * lineY)
                |> dsetfloat "t" (time + 0.01)

        _ ->
            d


updateBar : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateBar _ gMsg globalData ( d, t ) =
    let
        time =
            3 * dgetfloat d "t"

        angle =
            dgetfloat d "angle"
    in
    case gMsg of
        ComponentIntMsg num ->
            if 90 - 180 / 100 * toFloat num == angle then
                ( d |> bezier (modBy 4 (ceiling time)) (time - toFloat (floor time))
                , []
                , globalData
                )

            else
                ( (d |> dsetfloat "angle" (90 - 180 / 100 * toFloat num))
                    |> bezier (modBy 4 (ceiling time)) (time - toFloat (floor time))
                , []
                , globalData
                )

        _ ->
            ( d, [], globalData )


viewBar : ( Data, Int ) -> GlobalData -> Renderable
viewBar ( d, _ ) gd =
    let
        angle =
            dgetfloat d "angle"

        cx =
            widthToReal gd (ceiling (dgetfloat d "cx"))

        cy =
            heightToReal gd (ceiling (dgetfloat d "cy"))

        radius =
            widthToReal gd (ceiling (dgetfloat d "radius"))

        cp1x =
            widthToReal gd (ceiling (dgetfloat d "cp1x"))

        cp1y =
            heightToReal gd (ceiling (dgetfloat d "cp1y"))

        cp2x =
            widthToReal gd (ceiling (dgetfloat d "cp2x"))

        cp2y =
            heightToReal gd (ceiling (dgetfloat d "cp2y"))
    in
    if angle == -90 then
        group
            []
            [ shapes
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
            [ shapes
                [ fill Color.green
                ]
                [ path ( x, y ) [ renderBezier angle ( cx, cy ) radius ( cp1x, cp1y ) ( cp2x, cp2y ) ]
                , renderArc angle ( cx, cy ) radius
                ]
            , shapes
                [ stroke Color.darkGreen
                ]
                [ circle ( cx, cy ) (radius + 5)
                ]
            ]


renderArc : Float -> ( Float, Float ) -> Float -> Shape
renderArc angle ( cx, cy ) radius =
    if angle > 0 then
        arc ( cx, cy ) radius { startAngle = degrees angle, endAngle = degrees 180 - degrees angle, clockwise = True }

    else
        arc ( cx, cy ) radius { endAngle = degrees 180 - degrees angle, startAngle = degrees 360 + degrees angle, clockwise = True }


renderBezier : Float -> ( Float, Float ) -> Float -> ( Float, Float ) -> ( Float, Float ) -> PathSegment
renderBezier angle ( cx, cy ) radius ( cp1x, cp1y ) ( cp2x, cp2y ) =
    let
        x =
            cx + radius * cos (degrees angle)

        y =
            cy + radius * sin (degrees angle)
    in
    bezierCurveTo ( cp1x, cp1y ) ( cp2x, cp2y ) ( x, y )
