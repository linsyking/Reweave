module Movement exposing (..)

import Array
import Collision exposing (..)
import Common exposing (..)
import Math.Vector2



-- Deal with movement
-- moveMax : GActor


playerMove : Model -> Model
playerMove model =
    let
        player =
            getPlayer model

        solidcollision =
            gonnaCollideSolid player model

        pv =
            player.velocity

        pvx =
            floor (Math.Vector2.getX pv)

        pvy =
            floor (Math.Vector2.getY pv)

        px =
            player.position.x

        py =
            player.position.y

        newpos =
            if Array.isEmpty solidcollision then
                movePointPlain pv ( px, py )

            else
                ( px, py )

        putpos =
            Debug.log "Real New Position" newpos

        newvel =
            if Array.isEmpty solidcollision then
                pv

            else
                Math.Vector2.vec2 (Math.Vector2.getX pv) 0

        newplayer =
            { player | position = tupToPos newpos, velocity = newvel }

        newmodel =
            setPlayer newplayer model
    in
    newmodel
