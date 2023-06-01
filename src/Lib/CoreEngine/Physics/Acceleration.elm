module Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)

{-| This is the doc for this module

@docs putAccOn

-}

import Lib.CoreEngine.GameComponent.Base exposing (Data)


{-| putAccOn

Apply the acceleration (like gravity) to the velocity.

-}
putAccOn : Data -> Data
putAccOn ada =
    let
        ( acx, acy ) =
            ada.acceleration

        ( ovx, ovy ) =
            ada.velocity

        newvel =
            ( ovx + acx, ovy + acy )

        newdata =
            { ada | velocity = newvel }
    in
    newdata
