module Lib.Coordinate.Coordinates exposing (..)

import Base exposing (GlobalData, Msg)
import Constants exposing (..)
import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (style)



--- Transform Coordinates


relgenX : GlobalData -> ( Int, Int ) -> ( Int, Int ) -> List (Attribute msg)
relgenX gd ( x, y ) ( w, h ) =
    let
        rx =
            widthToReal gd x

        ry =
            heightToReal gd y

        rw =
            widthToReal gd w

        rh =
            heightToReal gd h
    in
    [ style "width" (String.fromFloat rw)
    , style "height" (String.fromFloat rh)
    , style "left" (String.fromFloat rx)
    , style "top" (String.fromFloat ry)
    , style "overflow" "hidden"
    , style "position" "absolute"
    ]


ffgenX : GlobalData -> ( Int, Int ) -> ( Int, Int ) -> List (Attribute msg)
ffgenX gd ( x, y ) ( w, h ) =
    let
        ( x1, y1 ) =
            fixedPosToReal gd ( x, y )

        rw =
            widthToReal gd w

        rh =
            heightToReal gd h
    in
    [ style "width" (String.fromFloat rw)
    , style "height" (String.fromFloat rh)
    , style "left" (String.fromFloat x1)
    , style "top" (String.fromFloat y1)
    , style "overflow" "hidden"
    , style "position" "fixed"
    ]


floatpairadd : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
floatpairadd ( x, y ) ( z, w ) =
    ( x + z, y + w )


fixedPosToReal : GlobalData -> ( Int, Int ) -> ( Float, Float )
fixedPosToReal gd ( x, y ) =
    floatpairadd (posToReal gd ( x, y )) ( gd.startLeft, gd.startTop )


posToReal : GlobalData -> ( Int, Int ) -> ( Float, Float )
posToReal gd ( x, y ) =
    let
        realWidth =
            gd.realWidth

        realHeight =
            gd.realHeight
    in
    ( toFloat realWidth * (toFloat x / toFloat (plWidth - 1)), toFloat realHeight * (toFloat y / toFloat (plHeight - 1)) )


widthToReal : GlobalData -> Int -> Float
widthToReal gd x =
    let
        realWidth =
            gd.realWidth
    in
    toFloat realWidth * (toFloat x / toFloat (plWidth - 1))


heightToReal : GlobalData -> Int -> Float
heightToReal gd x =
    let
        realHeight =
            gd.realHeight
    in
    toFloat realHeight * (toFloat x / toFloat (plHeight - 1))


maxHandW : ( Int, Int ) -> ( Int, Int )
maxHandW ( w, h ) =
    if w * 9 > h * 16 then
        ( floor (toFloat (h * 16) / 9), h )

    else
        ( w, floor (toFloat (w * 9) / 16) )


getStartPoint : ( Int, Int ) -> ( Float, Float )
getStartPoint ( w, h ) =
    let
        fw =
            toFloat h / 9 * 16

        fh =
            toFloat w / 16 * 9
    in
    if w * 9 > h * 16 then
        ( (toFloat w - fw) / 2, 0 )

    else
        ( 0, (toFloat h - fh) / 2 )


genBlank : String -> GlobalData -> Html Msg
genBlank color gd =
    let
        ( bw, bh ) =
            gd.browserViewPort

        lb =
            gd.startTop + toFloat gd.realHeight

        rt =
            gd.startLeft + toFloat gd.realWidth
    in
    div
        [ style "z-index" "100"
        ]
        [ div
            [ style "position" "fixed"
            , style "left" "0"
            , style "top" "0"
            , style "width" (String.fromInt bw)
            , style "height" (String.fromFloat gd.startTop)
            , style "background-color" color
            ]
            []
        , div
            [ style "position" "fixed"
            , style "left" "0"
            , style "top" (String.fromFloat lb)
            , style "width" (String.fromInt bw)
            , style "height" (String.fromFloat gd.startTop)
            , style "background-color" color
            ]
            []
        , div
            [ style "position" "fixed"
            , style "left" "0"
            , style "top" "0"
            , style "width" (String.fromFloat gd.startLeft)
            , style "height" (String.fromInt bh)
            , style "background-color" color
            ]
            []
        , div
            [ style "position" "fixed"
            , style "left" (String.fromFloat rt)
            , style "top" "0"
            , style "width" (String.fromFloat gd.startLeft)
            , style "height" (String.fromInt bh)
            , style "background-color" color
            ]
            []
        ]
