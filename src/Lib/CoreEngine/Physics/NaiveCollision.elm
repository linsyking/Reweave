module Lib.CoreEngine.Physics.NaiveCollision exposing
    ( getBoxPos
    , judgeCollision
    , judgeInCamera
    )

{-| This is the doc for this module

@docs getBoxPos

@docs judgeCollision

@docs judgeInCamera

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, GameComponent)
import Lib.CoreEngine.Physics.Base exposing (Position)
import Lib.CoreEngine.Physics.Vector exposing (addIntVec)


{-| getBoxPos
-}
getBoxPos : Position -> Box -> ( Position, Position )
getBoxPos ( x1, y1 ) b =
    let
        rx1 =
            x1 + b.offsetX

        ry1 =
            y1 + b.offsetY

        rx2 =
            rx1 + b.width - 1

        ry2 =
            ry1 + b.height - 1
    in
    ( ( rx1, ry1 ), ( rx2, ry2 ) )


{-| judgeCollision
-}
judgeCollision : ( Position, Position ) -> ( Position, Position ) -> Bool
judgeCollision ( p1, p2 ) ( p3, p4 ) =
    let
        p1x =
            Tuple.first p1

        p1y =
            Tuple.second p1

        p2x =
            Tuple.first p2

        p2y =
            Tuple.second p2

        p3x =
            Tuple.first p3

        p3y =
            Tuple.second p3

        p4x =
            Tuple.first p4

        p4y =
            Tuple.second p4
    in
    if p2y >= p3y && p1y <= p4y && p2x >= p3x && p1x <= p4x then
        True

    else
        False


{-| judgeInCamera
-}
judgeInCamera : GameComponent -> GameGlobalData -> Bool
judgeInCamera gc ggd =
    let
        gcd =
            gc.data

        gcsc =
            gcd.simplecheck

        ( op1x, op1y ) =
            gcd.position

        p1x =
            op1x + gcsc.offsetX

        p1y =
            op1y + gcsc.offsetY

        p2x =
            op1x + gcsc.width - 1

        p2y =
            op1y + gcsc.height - 1

        cpos =
            ggd.camera.position

        cposrb =
            addIntVec cpos ( 1919, 1079 )
    in
    judgeCollision ( ( p1x, p1y ), ( p2x, p2y ) ) ( cpos, cposrb )
