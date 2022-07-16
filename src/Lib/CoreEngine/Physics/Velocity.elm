module Lib.CoreEngine.Physics.Velocity exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Math.Vector2 exposing (vec2)


changeCVel : Data -> ( Float, Float ) -> Float -> Data
changeCVel c ( px, py ) k =
    let
        cm =
            c.mass

        punit =
            Math.Vector2.normalize (vec2 px -py)

        nm =
            Math.Vector2.scale (sqrt (10000 * k / toFloat cm)) punit

        newvx =
            Math.Vector2.getX nm

        newvy =
            Math.Vector2.getY nm

        ( ovx, ovy ) =
            c.velocity

        newdata =
            { c | velocity = ( newvx + ovx, newvy + ovy ) }
    in
    newdata