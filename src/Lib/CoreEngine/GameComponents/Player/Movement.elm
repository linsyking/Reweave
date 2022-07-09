module Lib.CoreEngine.GameComponents.Player.Movement exposing (..)

import Array
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.Physics.SolidCollision exposing (gonnaCollideSolidOrigin, movePointPlain)
import Math.Vector2



-- Deal with movement
-- moveMax : GActor


playerMove : GameComponent -> GameGlobalData -> GameComponent
playerMove gc ggd =
    let
        player =
            gc.data

        solidcollision =
            gonnaCollideSolidOrigin gc ggd

        pv =
            player.velocity

        ( pvx, pvy ) =
            pv

        pvv =
            Math.Vector2.vec2 pvx pvy

        ( px, py ) =
            player.position

        newpos =
            if Array.isEmpty solidcollision then
                movePointPlain pvv ( px, py )

            else
                ( px, py )

        -- putpos = Debug.log "Real New Position" newpos
        newvel =
            if Array.isEmpty solidcollision then
                pv

            else
                ( pvx, 0 )

        newplayer =
            { player | position = newpos, velocity = newvel }
    in
    { gc | data = newplayer }
