module Lib.CoreEngine.GameComponents.Player.Acceleration exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove)
import Math.Vector2 exposing (vec2)



-- Add acceleration to objects


putAccOn : GameGlobalData -> GameComponent -> GameComponent
putAccOn model actor =
    let
        ada =
            actor.data

        ( acx, acy ) =
            ada.acceleration

        ( ovx, ovy ) =
            ada.velocity

        vecax =
            if acx /= 0 && canMove actor model (vec2 acx 0) then
                acx

            else
                0

        vecay =
            if acy /= 0 && canMove actor model (vec2 0 acy) then
                acy

            else
                0

        newvel =
            ( ovx + vecax, ovy + vecay )

        newdata =
            { ada | velocity = newvel }
    in
    { actor | data = newdata }
