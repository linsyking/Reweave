module Lib.CoreEngine.Physics.Ground exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)



-- Judge the relationship between objects and the ground


isInAir : GameComponent -> GameGlobalData -> Bool
isInAir _ _ =
    True



-- if canJump (getPlayer model) model then
--     False
-- else
--     True


canJump : GameComponent -> GameGlobalData -> Bool
canJump actor model =
    True


isOnground : GameComponent -> GameGlobalData -> Bool
isOnground gc ggd =
    not (isInAir gc ggd)
