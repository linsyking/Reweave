module Lib.CoreEngine.Physics.SolidCollision exposing (..)

import Array
import Array2D
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos, judgeCollision)
import Lib.Tools.Math exposing (rfint)
import Math.Vector2 exposing (Vec2, vec2)
import Quantity exposing (times)


pointIsSolid : ( Int, Int ) -> GameGlobalData -> Bool
pointIsSolid ( x, y ) model =
    blockIsSolid model ( rfint x, rfint y )


pointOfSolid : ( Int, Int ) -> GameGlobalData -> Maybe ( Int, Int )
pointOfSolid ( x, y ) model =
    case Array2D.get (rfint x) (rfint y) model.solidmap of
        Just t ->
            if t > 0 then
                Just ( rfint x, rfint y )

            else
                Nothing

        Nothing ->
            if x < 0 || rfint x >= Tuple.first model.mapsize || rfint y >= Tuple.second model.mapsize then
                Just ( rfint x, rfint y )

            else
                Nothing


blockIsSolid : GameGlobalData -> ( Int, Int ) -> Bool
blockIsSolid model ( x, y ) =
    case Array2D.get x y model.solidmap of
        Just t ->
            if t > 0 then
                True

            else
                False

        Nothing ->
            if x < 0 || x >= Tuple.first model.mapsize || y >= Tuple.second model.mapsize then
                True

            else
                False



-- Judge if the line has some points that are solid


lineHasSolid : ( Int, Int ) -> ( Int, Int ) -> GameGlobalData -> Bool
lineHasSolid ( x1, y1 ) ( x2, y2 ) model =
    let
        x1t =
            rfint x1

        x2t =
            rfint x2

        y1t =
            rfint y1

        y2t =
            rfint y2
    in
    if x1 == x2 then
        --- Vertical Line
        let
            bdrange =
                if y1 > y2 then
                    List.range y2t y1t

                else
                    List.range y1t y2t

            totest =
                List.map (\i -> ( x1t, i )) bdrange
        in
        List.any (blockIsSolid model) totest

    else if y1 == y2 then
        --- Horizontal Line
        let
            bdrange =
                if x1 > x2 then
                    List.range x2t x1t

                else
                    List.range x1t x2t

            totest =
                List.map (\i -> ( i, y1t )) bdrange
        in
        List.any (blockIsSolid model) totest

    else
        -- Undefined Behavior !!!
        True


velToDis : Float -> Float
velToDis x =
    x / 15



--- Judge if an actor can move toward a specific direction (If there exists gap)


canMove : Data -> GameGlobalData -> Vec2 -> Bool
canMove actor model drt =
    let
        xv =
            Math.Vector2.getX drt

        yv =
            Math.Vector2.getY drt

        cbox =
            actor.simplecheck

        ( ( x1, y1 ), ( x2, y2 ) ) =
            getBoxPos actor.position cbox
    in
    if xv == 0 && yv == 0 then
        True

    else if xv == 0 && yv > 0 then
        not (lineHasSolid ( x1, y1 - 1 ) ( x2, y1 - 1 ) model)

    else if xv == 0 && yv < 0 then
        not (lineHasSolid ( x1, y2 + 1 ) ( x2, y2 + 1 ) model)

    else if xv > 0 && yv == 0 then
        not (lineHasSolid ( x2 + 1, y1 ) ( x2 + 1, y2 ) model)

    else if xv < 0 && yv == 0 then
        not (lineHasSolid ( x1 - 1, y1 ) ( x1 - 1, y2 ) model)

    else
        --- Maybe undefined
        False


movePointPlain : Vec2 -> ( Int, Int ) -> ( Int, Int )
movePointPlain vec ( x, y ) =
    let
        vx =
            Math.Vector2.getX vec

        vy =
            Math.Vector2.getY vec
    in
    ( x + floor (velToDis vx), y + floor -(velToDis vy) )


gonnaSolidCollide : Data -> GameGlobalData -> List ( Int, Int )
gonnaSolidCollide gc ggd =
    Array.toList (gonnaCollideSolidOrigin gc ggd)


genSplits : Int -> Int -> Int -> Array.Array Int
genSplits a b s =
    if a >= b then
        Array.empty

    else
        let
            fgs =
                (b - a) // s
        in
        if modBy s (b - a) == 0 then
            Array.map (\x -> x * s + a) (Array.fromList (List.range 0 fgs))

        else
            Array.push b (Array.map (\x -> x * s + a) (Array.fromList (List.range 0 fgs)))


gonnaCollideSolidOrigin : Data -> GameGlobalData -> Array.Array ( Int, Int )
gonnaCollideSolidOrigin actor model =
    let
        cbox =
            actor.simplecheck

        ( ( x1A, y1A ), ( x2A, y2A ) ) =
            getBoxPos actor.position cbox

        velv =
            actor.velocity

        velvx =
            velToDis (Tuple.first velv)

        velvy =
            velToDis (Tuple.second velv)

        disv =
            vec2 velvx -velvy

        disvlength =
            Math.Vector2.length disv

        frags =
            if disvlength > 5 then
                floor (Math.Vector2.length disv / 2)

            else
                floor (Math.Vector2.length disv)

        dunit =
            if disvlength > 5 then
                Math.Vector2.scale 2 (Math.Vector2.normalize disv)

            else
                Math.Vector2.normalize disv

        alfs =
            Array.push disv (Array.fromList (List.map (\x -> Math.Vector2.scale (toFloat x) dunit) (List.range 1 frags)))

        -- widthfrags = floor ( (toFloat (x2A - x1A)) / 5)
        -- heightfrags = floor ( (toFloat (y2A - y1A)) / 5)
        mapToNew : ( Int, Int ) -> Int -> ( Int, Int )
        mapToNew ( x, y ) i =
            case Array.get i alfs of
                Just t ->
                    ( x + floor (Math.Vector2.getX t), y + floor (Math.Vector2.getY t) )

                Nothing ->
                    ( x, y )

        rightAgents =
            Array.map (\x -> ( x2A, x )) (genSplits y1A y2A 5)

        leftAgents =
            Array.map (\x -> ( x1A, x )) (genSplits y1A y2A 5)

        topAgents =
            Array.map (\x -> ( x, y1A )) (genSplits x1A x2A 5)

        bottomAgents =
            Array.map (\x -> ( x, y2A )) (genSplits x1A x2A 5)

        lefttopAgents =
            Array.fromList (List.append (Array.toList leftAgents) (List.drop 1 (Array.toList topAgents)))

        leftbottomAgents =
            Array.fromList (List.append (Array.toList leftAgents) (List.drop 1 (Array.toList bottomAgents)))

        righttopAgents =
            Array.fromList (List.append (Array.toList rightAgents) (List.drop 1 (Array.toList topAgents)))

        rightbottomAgents =
            Array.fromList (List.append (Array.toList rightAgents) (Array.toList bottomAgents))

        moveAgent : Array.Array ( Int, Int ) -> Int -> Array.Array ( Int, Int )
        moveAgent agents index =
            if index == frags + 1 then
                Array.empty

            else
                let
                    curagents =
                        Array.map (\x -> mapToNew x index) agents

                    testres =
                        Array.map (\x -> pointOfSolid x model) curagents

                    td =
                        List.filterMap (\x -> x) (Array.toList testres)
                in
                if List.isEmpty td then
                    moveAgent agents (index + 1)

                else
                    Array.fromList td
    in
    if velvx == 0 && velvy == 0 then
        Array.empty

    else if velvx == 0 && velvy > 0 then
        --- Up
        moveAgent topAgents 0

    else if velvx == 0 && velvy < 0 then
        --- Down
        moveAgent bottomAgents 0

    else if velvx > 0 && velvy == 0 then
        --- Right
        moveAgent rightAgents 0

    else if velvx < 0 && velvy == 0 then
        --- Left
        moveAgent leftAgents 0

    else if velvx < 0 && velvy > 0 then
        --- LeftUp
        moveAgent lefttopAgents 0

    else if velvx < 0 && velvy < 0 then
        --- LeftDown
        moveAgent leftbottomAgents 0

    else if velvx > 0 && velvy > 0 then
        --- RightUp
        moveAgent righttopAgents 0

    else if velvx > 0 && velvy < 0 then
        --- RightDown
        moveAgent rightbottomAgents 0

    else
        Array.empty



--- Judge if next frame the actor will collide with solid


judgeEasyCollision : Data -> ( Int, Int ) -> Bool
judgeEasyCollision d ( x, y ) =
    let
        gbx =
            getBoxPos d.position d.simplecheck
    in
    judgeCollision gbx ( ( x * brickSize, y * brickSize ), ( x * brickSize + brickSize - 1, y * brickSize + brickSize - 1 ) )


moveTilCollide : Data -> List ( Int, Int ) -> Data
moveTilCollide d xs =
    let
        ( vx, vy ) =
            d.velocity

        tdisx =
            velToDis vx

        tdisy =
            -(velToDis vy)

        qs =
            List.range 1 1000

        ( opx, opy ) =
            d.position

        qsm =
            List.map (\x -> ( floor (toFloat opx + tdisx * toFloat x / 1000), floor (toFloat opy + tdisy * toFloat x / 1000) )) qs

        alls =
            List.filter
                (\pos ->
                    let
                        newd =
                            { d | position = pos }
                    in
                    List.any (\x -> not (judgeEasyCollision newd x)) xs
                )
                qsm

        qh =
            Maybe.withDefault d.position (List.head (List.reverse alls))
    in
    { d | position = qh }
