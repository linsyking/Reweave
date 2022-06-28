module Acceleration exposing (..)

import Array
import Collision exposing (canMove)
import Common exposing (GActor, Model, dbge)
import Math.Vector2 exposing (vec2)



-- Add acceleration to objects


putAccOn : Model -> GActor -> GActor
putAccOn model actor =
    let
        acx =
            Math.Vector2.getX actor.acceleration

        acy =
            Math.Vector2.getY actor.acceleration

        ovx =
            Math.Vector2.getX actor.velocity

        ovy =
            Math.Vector2.getY actor.velocity

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
    in
    { actor | velocity = vec2 (ovx + vecax) (ovy + vecay) }


addAcc : Model -> Model
addAcc model =
    let
        newactors =
            Array.map (putAccOn model) model.actors
    in
    { model | actors = newactors }
