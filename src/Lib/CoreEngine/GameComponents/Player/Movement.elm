module Lib.CoreEngine.GameComponents.Player.Movement exposing (..)

import Array2D exposing (Array2D)
import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.CollisionShape exposing (CShape(..), judgeShape)
import Lib.CoreEngine.Physics.Ground exposing (isOnground)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove, movePointPlain, moveTilCollide)
import Math.Vector2 exposing (vec2)



-- Deal with movement


solidCollisionMove : List ( Int, Int ) -> GameGlobalData -> Data -> Data
solidCollisionMove ls ggd d =
    let
        ( pvx, pvy ) =
            d.velocity

        -- dhk = Debug.log "collision" (judgeShape d.velocity ls, d.position, newvel)
        moved =
            moveTilCollide d (getNearBySolid ggd d)

        newvel =
            case judgeShape d ls of
                CTOP ->
                    ( pvx, 0 )

                CBOTTOM ->
                    ( pvx, 0 )

                CRIGHT ->
                    ( 0, pvy )

                CLEFT ->
                    ( 0, pvy )

                CBOTTOMLEFT ->
                    ( 0, 0 )

                CBOTTOMRIGHT ->
                    ( 0, 0 )

                CTOPLEFT ->
                    ( 0, 0 )

                CTOPRIGHT ->
                    ( 0, 0 )
    in
    { moved | velocity = newvel }


getNearBySolid : GameGlobalData -> Data -> List ( Int, Int )
getNearBySolid ggd d =
    let
        ( ( px, py ), ( p2x, p2y ) ) =
            getBoxPos d.position d.simplecheck

        ( pb1, pb2 ) =
            ( px // brickSize - 2, py // brickSize - 2 )

        ( pb3, pb4 ) =
            ( p2x // brickSize + 2, p2y // brickSize + 2 )

        ir =
            List.range pb1 pb3

        jr =
            List.range pb2 pb4
    in
    List.foldl
        (\i all ->
            List.foldl
                (\j all2 ->
                    case Array2D.get i j ggd.solidmap of
                        Just v ->
                            if v > 0 then
                                all2 ++ [ ( i, j ) ]

                            else
                                all2

                        Nothing ->
                            all2
                )
                all
                jr
        )
        []
        ir
