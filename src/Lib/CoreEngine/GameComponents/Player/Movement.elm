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

        ( mvdx, mvdy ) =
            moved.position

        jshape =
            judgeShape d ls

        newpos =
            case jshape of
                CRCORNERBOOST ->
                    ( mvdx, mvdy - 20 )

                CLCORNERBOOST ->
                    ( mvdx, mvdy - 20 )

                _ ->
                    ( mvdx, mvdy )

        dasada =
            Debug.log "shape" jshape

        newvel =
            case jshape of
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
                    if pvy > -100 then
                        ( -40, 0 )

                    else
                        ( -40 + pvy, 0 )

                CBOOSTBOTTOMRIGHT ->
                    if pvy > -100 then
                        ( 40, 0 )

                    else
                        ( 40 - pvy, 0 )

                CBOOSTTOPLEFT ->
                    ( -40, 0 )

                CBOOSTTOPRIGHT ->
                    ( 40, 0 )

                CRCORNERBOOST ->
                    ( pvx + 30, pvy )

                CLCORNERBOOST ->
                    ( pvx - 30, pvy )
    in
    { moved | velocity = newvel, position = newpos }
