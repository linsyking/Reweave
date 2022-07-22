module Lib.CoreEngine.Physics.Ground exposing (..)

{-| This is the doc for this module

@docs isInAir

@docs canJump

@docs isOnground

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove)
import Math.Vector2 exposing (vec2)



-- Judge the relationship between objects and the ground


{-| isInAir
-}
isInAir : Data -> GameGlobalData -> Bool
isInAir gc ggd =
    let
        ( _, vely ) =
            gc.velocity
    in
    if vely > 0 then
        True

    else
        canMove gc ggd (vec2 0 -1)


{-| canJump
-}
canJump : Data -> GameGlobalData -> Bool
canJump actor model =
    isOnground actor model


{-| isOnground
-}
isOnground : Data -> GameGlobalData -> Bool
isOnground gc ggd =
    not (isInAir gc ggd)
