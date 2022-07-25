module Lib.CoreEngine.GameComponents.Goomba.Movement exposing
    ( checkCollision
    , solidCollisionMove
    )

{-| This is the doc for this module

@docs checkCollision

@docs solidCollisionMove

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.CollisionShape exposing (CShape(..), judgeShape)
import Lib.CoreEngine.Physics.Ground exposing (isOnground)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove, getNearBySolid, moveTilCollide)
import Lib.DefinedTypes.Parser exposing (dgetfloat)
import Math.Vector2 exposing (vec2)


{-| checkCollision
-}
checkCollision : GameGlobalData -> Data -> Data
checkCollision ggd d =
    let
        ( rvx, vy ) =
            d.velocity

        vx =
            if abs rvx <= 10 then
                if rvx >= 0 then
                    20

                else
                    -20

            else
                rvx

        ( newvx, newvy ) =
            if (vx < 0 && not (canMove d ggd (vec2 -1 0))) || (vx > 0 && not (canMove d ggd (vec2 1 0))) then
                ( -vx, vy )

            else
                ( vx, vy )

        cv =
            dgetfloat d.extra "constv"

        newnewv =
            if isOnground d ggd then
                if newvx >= 0 then
                    ( cv, newvy )

                else
                    ( -cv, newvy )

            else
                ( newvx / 1.001, newvy )
    in
    { d | velocity = newnewv }


{-| solidCollisionMove
-}
solidCollisionMove : List ( Int, Int ) -> GameGlobalData -> Data -> Data
solidCollisionMove ls ggd d =
    let
        cv =
            dgetfloat d.extra "constv"

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
                    ( -cv, pvy )

                CLEFT ->
                    ( cv, pvy )

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
