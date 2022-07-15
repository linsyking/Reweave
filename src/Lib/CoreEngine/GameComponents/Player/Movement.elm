module Lib.CoreEngine.GameComponents.Player.Movement exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.CollisionShape exposing (CShape(..), judgeShape)
import Lib.CoreEngine.Physics.SolidCollision exposing (getNearBySolid, moveTilCollide)



-- Deal with movement


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

                CBOOSTBOTTOMLEFT ->
                    ( -10, 0 )

                CBOOSTBOTTOMRIGHT ->
                    ( 10, 0 )

                CBOOSTTOPLEFT ->
                    ( -10, 0 )

                CBOOSTTOPRIGHT ->
                    ( 10, 0 )
    in
    { moved | velocity = newvel }
