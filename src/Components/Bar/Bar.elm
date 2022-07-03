module Components.Bar.Bar exposing (..)

import Base exposing (GlobalData, Msg)
import Dict exposing (Dict)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Component.Base exposing (DefinedTypes(..), ComponentTMsg(..), Data, dgetbool, dgetfloat, dsetfloat)
import Constants exposing (..)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color


initBar : Int -> ComponentTMsg -> Data
initBar _ _ =
    Dict.fromList
        [ ( "cx", CDFloat 120 )
        , ( "cy", CDFloat 120 )
        , ( "radius", CDFloat 100 )
        , ( "cp1x", CDFloat 110 )
        , ( "cp1y", CDFloat 28 )
        , ( "cp2x", CDFloat 112 )
        , ( "cp2y", CDFloat 179 )
        , ( "t", CDFloat 0 )
        , ( "clockwise", CDInt 0 )
        , ( "angle", CDFloat -90 )
        ]

bezier : Int -> Float -> Data -> Data
bezier clockwise t d =
    let
        cx = dgetfloat d "cx"
        cy = dgetfloat d "cy"
        radius = dgetfloat d "radius"
        angle = dgetfloat d "angle"
        lineY = cy + radius * sin( degrees angle )
        k = (90 - abs(angle)) / 2
        m = radius * cos( degrees angle ) / 8
        cp1x =  cx - m + 20 * t
        cp1y = lineY - k + k * t
        cp2x = cx - m - 20 * t
        cp2y = lineY + k - k * t
        cp1CounterX = cx + 20 - m - 20 * t
        cp1CounterY = lineY - k * t 
        cp2CounterX = cx - m - 20 + 20 * t
        cp2CounterY = lineY + k * t 
    in
        case clockwise of
            1 ->
                d 
                    |> dsetfloat "cp1x" cp1x
                    |> dsetfloat "cp1y" cp1y
                    |> dsetfloat "cp2x" cp2x
                    |> dsetfloat "cp2y" cp2y
                    |> dsetfloat "t" (t+0.01)
            0 ->
                d 
                    |> dsetfloat "cp1x" cp1CounterX
                    |> dsetfloat "cp1y" cp1CounterY
                    |> dsetfloat "cp2x" cp2CounterX
                    |> dsetfloat "cp2y" cp2CounterY
                    |> dsetfloat "t" (t+0.01)
            2 ->
                d 
                    |> dsetfloat "cp1x" cp1CounterX
                    |> dsetfloat "cp1y" (-cp1CounterY+2*lineY)
                    |> dsetfloat "cp2x" cp2CounterX
                    |> dsetfloat "cp2y" (-cp2CounterY+2*lineY)
                    |> dsetfloat "t" (t+0.01)
            3 ->
                d 
                    |> dsetfloat "cp1x" cp1x
                    |> dsetfloat "cp1y" (-cp1y+2*lineY)
                    |> dsetfloat "cp2x" cp2x
                    |> dsetfloat "cp2y" (-cp2y+2*lineY)
                    |> dsetfloat "t" (t+0.01)
            _ -> d



updateBar : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateBar msg gMsg globalData ( d, t ) =
        let
            time = dgetfloat d "t"
            clockwise = dgetbool d "clockwise"
        in
        case gMsg of
            ComponentIntMsg num ->
                ( d |> dsetfloat "angle" (90 - 180 / 100 * toFloat num), NullComponentMsg, globalData )

            _ ->
                ( bezier (modBy 4 ( ceiling time )) ( time - toFloat( floor time ) ) d, NullComponentMsg, globalData )


viewBar : ( Data, Int ) -> GlobalData -> Renderable
viewBar ( d, _ ) globalData =
        let
            angle = dgetfloat d "angle"
            cx = dgetfloat d "cx"
            cy = dgetfloat d "cy"
            radius = dgetfloat d "radius"
            cp1x = dgetfloat d "cp1x"
            cp1y = dgetfloat d "cp1y"
            cp2x = dgetfloat d "cp2x"
            cp2y = dgetfloat d "cp2y"
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
                        [ circle ( cx, cy ) ( radius + 5 )
                        ]
                    ]
            else
                let
                    x = cx - radius * cos( degrees angle )
                    y = cy + radius * sin( degrees angle )
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
                        [ circle ( cx, cy ) ( radius + 5 )
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
        x = cx + radius * cos( degrees angle )
        y = cy + radius * sin( degrees angle )
    in
    
        bezierCurveTo ( cp1x, cp1y ) ( cp2x, cp2y ) ( x, y )
