module Collision exposing (..)

import Array
import Array2D
import Common exposing (..)
import Math.Vector2 exposing (Vec2, vec2)


isRiding : GActor -> Model -> Maybe GObject
isRiding actor _ =
    if actor.position.y < screen_height - 70 then
        Just (Solid (GSolid (Position 0 0) 1))
        --- Test

    else
        Nothing


canJump : GActor -> Model -> Bool
canJump actor model =
    case isRiding actor model of
        Just _ ->
            False

        Nothing ->
            True



--- Judge if a point is in the solid


pointIsSolid : ( Int, Int ) -> Model -> Bool
pointIsSolid ( x, y ) model =
    blockIsSolid model ( rfint x, rfint y )


pointOfSolid : ( Int, Int ) -> Model -> Maybe ( Int, Int )
pointOfSolid ( x, y ) model =
    case Array2D.get (rfint x) (rfint y) model.solidmap of
        Just t ->
            if t > 0 then
                Just ( rfint x, rfint y )

            else
                Nothing

        Nothing ->
            if x < 0 || rfint x >= Tuple.first model.mapSize || rfint y >= Tuple.second model.mapSize then
                Just ( rfint x, rfint y )

            else
                Nothing


blockIsSolid : Model -> ( Int, Int ) -> Bool
blockIsSolid model ( x, y ) =
    case Array2D.get x y model.solidmap of
        Just t ->
            if t > 0 then
                True

            else
                False

        Nothing ->
            if x < 0 || x >= Tuple.first model.mapSize || y >= Tuple.second model.mapSize then
                True

            else
                False



-- Judge if the line has some points that are solid


lineHasSolid : ( Int, Int ) -> ( Int, Int ) -> Model -> Bool
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
        dbge [ totest ] (List.any (blockIsSolid model) totest)

    else
        -- Undefined Behavior !!!
        True



--- Judge if an actor can move toward a specific direction (If there exists gap)


canMove : GActor -> Model -> Vec2 -> Bool
canMove actor model drt =
    let
        xv =
            Math.Vector2.getX drt

        yv =
            Math.Vector2.getY drt

        cbox =
            getCollisionBox actor

        relp =
            cbox.relativePosition

        x1 =
            actor.position.x + relp.x

        y1 =
            actor.position.y + relp.y

        x2 =
            x1 + cbox.width - 1

        y2 =
            y1 + cbox.height - 1
    in
    dbge
        [ x1, y1, x2, y2 ]
        (if xv == 0 && yv == 0 then
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
        )


movePointPlain : Vec2 -> ( Int, Int ) -> ( Int, Int )
movePointPlain vec ( x, y ) =
    let
        vx =
            Math.Vector2.getX vec

        vy =
            Math.Vector2.getY vec
    in
    ( x + floor (velToDis vx), y + floor -(velToDis vy) )


gonnaCollideSolid : GActor -> Model -> Array.Array ( Int, Int )
gonnaCollideSolid actor model =
    let
        cbox =
            getCollisionBox actor

        x1A =
            actor.position.x + cbox.relativePosition.x

        y1A =
            actor.position.y + cbox.relativePosition.y

        x2A =
            x1A + cbox.width - 1

        y2A =
            y1A + cbox.height - 1

        -- x1B =
        --     x1A // 8
        -- y1B =
        --     y1A // 8
        -- x2B =
        --     x2A // 8
        -- y2B =
        --     y2A // 8
        velv =
            actor.velocity

        -- ( movedx1A, movedy1A ) =
        --     movePointPlain velv ( x1A, y1A )
        -- movedx2A =
        --     movedx1A + cbox.width
        -- movedy2A =
        --     movedy1A + cbox.height
        velvx =
            velToDis (Math.Vector2.getX velv)

        velvy =
            velToDis (Math.Vector2.getY velv)

        disv =
            vec2 velvx -velvy

        -- calcPos =
        --     Debug.log "Want to move to" ( x1A + floor velvx, y1A + floor -velvy )
        -- ply2 =
        --     Debug.log "Playery" (y2A - floor velvy)
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

        mapMaybe : Maybe ( Int, Int ) -> ( Int, Int )
        mapMaybe x =
            case x of
                Just t ->
                    t

                Nothing ->
                    ( 0, 0 )

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
                        List.map mapMaybe (List.filter testMaybe (Array.toList testres))
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
