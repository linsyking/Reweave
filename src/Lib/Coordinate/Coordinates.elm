module Lib.Coordinate.Coordinates exposing
    ( fixedPosToReal
    , posToReal
    , widthToReal
    , heightToReal
    , maxHandW
    , getStartPoint
    , judgeMouse
    , fromMouseToReal
    )

{-|


# Coordinate

This module deals with the coordinate transformation.

This module is very important because it can calculate the correct position of the point you want to draw.

@docs fixedPosToReal

@docs posToReal

@docs widthToReal

@docs heightToReal

@docs maxHandW

@docs getStartPoint

@docs judgeMouse

@docs fromMouseToReal

-}

import Base exposing (GlobalData)


plHeight : Int
plHeight =
    1080


plWidth : Int
plWidth =
    1920



--- Transform Coordinates


floatpairadd : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
floatpairadd ( x, y ) ( z, w ) =
    ( x + z, y + w )


{-| fixedPosToReal
-}
fixedPosToReal : GlobalData -> ( Int, Int ) -> ( Float, Float )
fixedPosToReal gd ( x, y ) =
    floatpairadd (posToReal gd ( x, y )) ( gd.startLeft, gd.startTop )


{-| posToReal
-}
posToReal : GlobalData -> ( Int, Int ) -> ( Float, Float )
posToReal gd ( x, y ) =
    let
        realWidth =
            gd.realWidth

        realHeight =
            gd.realHeight
    in
    ( toFloat realWidth * (toFloat x / toFloat (plWidth - 1)), toFloat realHeight * (toFloat y / toFloat (plHeight - 1)) )


{-| widthToReal
-}
widthToReal : GlobalData -> Int -> Float
widthToReal gd x =
    let
        realWidth =
            gd.realWidth
    in
    toFloat realWidth * (toFloat x / toFloat (plWidth - 1))


{-| heightToReal
-}
heightToReal : GlobalData -> Int -> Float
heightToReal =
    widthToReal


{-| maxHandW
-}
maxHandW : ( Int, Int ) -> ( Int, Int )
maxHandW ( w, h ) =
    if w * 9 > h * 16 then
        ( floor (toFloat (h * 16) / 9), h )

    else
        ( w, floor (toFloat (w * 9) / 16) )


{-| getStartPoint
-}
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


{-| judgeMouse
-}
judgeMouse : GlobalData -> ( Float, Float ) -> ( Int, Int ) -> ( Int, Int ) -> Bool
judgeMouse gd ( mx, my ) ( x, y ) ( w, h ) =
    let
        ( rpx, rpy ) =
            posToReal gd ( x, y )

        rw =
            widthToReal gd w

        rh =
            heightToReal gd h

        mpx =
            mx

        mpy =
            my
    in
    if rpx <= mpx && mpx <= rpx + rw && rpy <= mpy && mpy <= rpy + rh then
        True

    else
        False


{-| fromMouseToReal
-}
fromMouseToReal : GlobalData -> ( Float, Float ) -> ( Float, Float )
fromMouseToReal gd ( px, py ) =
    ( px - gd.startLeft, py - gd.startTop )
