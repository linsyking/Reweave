module Lib.CoreEngine.Physics.Acceleration exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (Data)


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
