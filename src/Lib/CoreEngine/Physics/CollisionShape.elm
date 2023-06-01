module Lib.CoreEngine.Physics.CollisionShape exposing
    ( CShape(..)
    , judgeShape
    )

{-| This is the doc for this module

@docs CShape

@docs judgeShape

-}

import Lib.CoreEngine.Base exposing (brickSize)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)



-- Judge the collision shape


{-| CShape

Collision Shape for solid collision. When a collision happens, there must be a shape how the object collide with the solid.

For example, CTOP means that the top area of the object hits the solid.

CBOOSTXX means the corner boost collision. It is similar to the game Braid.

CXCORNERBOOST means that the object hits the very top of the solid, and should not be counted as collision.

-}
type CShape
    = CTOP
    | CBOTTOM
    | CRIGHT
    | CLEFT
    | CTOPRIGHT
    | CTOPLEFT
    | CBOTTOMRIGHT
    | CBOTTOMLEFT
    | CBOOSTTOPRIGHT
    | CBOOSTTOPLEFT
    | CBOOSTBOTTOMLEFT
    | CBOOSTBOTTOMRIGHT
    | CRCORNERBOOST
    | CLCORNERBOOST


{-| judgeYSame
-}
judgeYSame : List ( Int, Int ) -> Bool
judgeYSame ls =
    let
        h =
            Tuple.second (Maybe.withDefault ( 0, 0 ) (List.head ls))
    in
    List.all (\( _, y ) -> y == h) ls


{-| judgeXSame
-}
judgeXSame : List ( Int, Int ) -> Bool
judgeXSame ls =
    let
        h =
            Tuple.first (Maybe.withDefault ( 0, 0 ) (List.head ls))
    in
    List.all (\( x, _ ) -> x == h) ls


{-| judgeShape
Judge the shape of the collision.
-}
judgeShape : Data -> List ( Int, Int ) -> CShape
judgeShape d ls =
    let
        ( x, y ) =
            d.velocity

        xsame =
            judgeXSame ls

        ysame =
            judgeYSame ls

        ( ( x1, y1 ), ( x2, _ ) ) =
            getBoxPos d.position d.simplecheck
    in
    case ls of
        [ ( lfx, lfy ) ] ->
            let
                ( blx1, _ ) =
                    ( lfx * brickSize, lfy * brickSize )

                ( blx2, bly2 ) =
                    ( (lfx + 1) * brickSize - 1, (lfy + 1) * brickSize - 1 )
            in
            if x2 < blx1 then
                if x > 200 then
                    CRCORNERBOOST

                else
                    CRIGHT

            else if x1 > blx2 then
                if x < -200 then
                    CLCORNERBOOST

                else
                    CLEFT

            else if y1 > bly2 then
                if x1 >= blx2 - 5 then
                    CBOOSTTOPRIGHT

                else if x2 <= blx1 + 5 then
                    CBOOSTTOPLEFT

                else
                    CTOP

            else if x1 >= blx2 - 5 then
                CBOOSTBOTTOMRIGHT

            else if x2 <= blx1 + 5 then
                CBOOSTBOTTOMLEFT

            else
                CBOTTOM

        _ ->
            if y >= 0 && x >= 0 then
                if ysame then
                    CTOP

                else if xsame then
                    CRIGHT

                else
                    CTOPRIGHT

            else if y >= 0 && x < 0 then
                if ysame then
                    CTOP

                else if xsame then
                    CLEFT

                else
                    CTOPLEFT

            else if y < 0 && x >= 0 then
                if ysame then
                    CBOTTOM

                else if xsame then
                    CRIGHT

                else
                    CBOTTOMRIGHT

            else if ysame then
                CBOTTOM

            else if xsame then
                CLEFT

            else
                CBOTTOMLEFT
