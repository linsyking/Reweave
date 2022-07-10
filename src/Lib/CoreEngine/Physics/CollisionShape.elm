module Lib.CoreEngine.Physics.CollisionShape exposing (..)

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


judgeShape : ( Float, Float ) -> List ( Int, Int ) -> CShape
judgeShape ( x, y ) ls =
    let
        xsame =
            judgeXSame ls

        ysame =
            judgeYSame ls

        dsadd =
            Debug.log "das" ( xsame, ysame )
    in
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
