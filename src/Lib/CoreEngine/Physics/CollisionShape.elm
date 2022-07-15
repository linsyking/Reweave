module Lib.CoreEngine.Physics.CollisionShape exposing (..)

import Lib.CoreEngine.Base exposing (brickSize)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)



-- Judge the collision shape


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


judgeYSame : List ( Int, Int ) -> Bool
judgeYSame ls =
    let
        h =
            Tuple.second (Maybe.withDefault ( 0, 0 ) (List.head ls))
    in
    List.all (\( _, y ) -> y == h) ls


judgeXSame : List ( Int, Int ) -> Bool
judgeXSame ls =
    let
        h =
            Tuple.first (Maybe.withDefault ( 0, 0 ) (List.head ls))
    in
    List.all (\( x, _ ) -> x == h) ls


judgeShape : Data -> List ( Int, Int ) -> CShape
judgeShape d ls =
    let
        ( x, y ) =
            d.velocity

        xsame =
            judgeXSame ls

        ysame =
            judgeYSame ls

        dsds =
            Debug.log "same" ( xsame, ysame )

        ( ( x1, y1 ), ( x2, y2 ) ) =
            getBoxPos d.position d.simplecheck
    in
    case ls of
        [ ( lfx, lfy ) ] ->
            if x2 < lfx * brickSize then
                CRIGHT

            else if x1 >= (lfx + 1) * brickSize then
                CLEFT

            else if y1 > lfy * brickSize then
                CTOP

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
