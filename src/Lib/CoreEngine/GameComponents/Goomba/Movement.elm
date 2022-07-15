module Lib.CoreEngine.GameComponents.Goomba.Movement exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.CollisionShape exposing (CShape(..), judgeShape)
import Lib.CoreEngine.Physics.Ground exposing (isOnground)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove, getNearBySolid, moveTilCollide)
import Math.Vector2 exposing (vec2)


checkCollision : GameGlobalData -> Data -> Data
checkCollision ggd d =
    let
        ( vx, vy ) =
            d.velocity

        ( newvx, newvy ) =
            if (vx < 0 && not (canMove d ggd (vec2 -1 0))) || (vx > 0 && not (canMove d ggd (vec2 1 0))) then
                ( -vx, vy )

            else
                ( vx, vy )

        newnewv =
            if isOnground d ggd then
                if newvx >= 0 then
                    ( 50, newvy )

                else
                    ( -50, newvy )

            else
                ( newvx / 1.001, newvy )
    in
    { d | velocity = newnewv }


solidCollisionMove : List ( Int, Int ) -> GameGlobalData -> Data -> Data
solidCollisionMove ls ggd d =
    let
        ( pvx, pvy ) =
            d.velocity

        moved =
            moveTilCollide d (getNearBySolid ggd d)

        newvel =
            case judgeShape d ls of
                CTOP ->
                    ( pvx, 0 )

                CBOTTOM ->
                    ( pvx, 0 )

                CRIGHT ->
                    ( -pvx, pvy )

                CLEFT ->
                    ( -pvx, pvy )

                CBOTTOMLEFT ->
                    ( 0, 0 )

                CBOTTOMRIGHT ->
                    ( 0, 0 )

                CTOPLEFT ->
                    ( 0, 0 )

                CTOPRIGHT ->
                    ( 0, 0 )

                _ ->
                    ( 0, 0 )
    in
    { moved | velocity = newvel }
