module Lib.CoreEngine.GameComponents.Player.Movement exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.CollisionShape exposing (CShape(..), judgeShape)
import Lib.CoreEngine.Physics.Ground exposing (isOnground)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove, movePointPlain, moveTilCollide)
import Math.Vector2 exposing (vec2)



-- Deal with movement
-- moveMax : GActor


playerMove : Data -> GameGlobalData -> Data
playerMove player ggd =
    let
        pv =
            player.velocity

        ( pvx, pvy ) =
            pv

        ( npx, npy ) =
            rpv

        rpv =
            if isOnground player ggd then
                ( pvx, 0 )

            else
                pv

        pvv =
            Math.Vector2.vec2 npx npy

        newpos =
            movePointPlain pvv player.position

        newplayer =
            { player | position = newpos, velocity = rpv }
    in
    newplayer


solidCollisionMove : List ( Int, Int ) -> Data -> Data
solidCollisionMove ls d =
    let
        ( pvx, pvy ) =
            d.velocity

        moved =
            moveTilCollide d ls

        -- d
        das =
            Debug.log "movetil" moved.position

        newvel =
            case judgeShape d.velocity ls of
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
