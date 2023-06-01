module Lib.CoreEngine.Physics.InterCollision exposing (gonnaInterColllide)

{-| This is the doc for this module

@docs gonnaInterColllide

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos, judgeCollision)


{-| gonnaInterColllide

Detect if two objects will collide.

-}
gonnaInterColllide : GameComponent -> GameComponent -> ( GameComponentTMsg, GameComponentTMsg )
gonnaInterColllide gc1 gc2 =
    let
        sp1 =
            gc1.data.simplecheck

        sp2 =
            gc2.data.simplecheck

        op1 =
            gc1.data.position

        op2 =
            gc2.data.position
    in
    if judgeCollision (getBoxPos op1 sp1) (getBoxPos op2 sp2) then
        ( genInterFromOneSide gc1 gc2, genInterFromOneSide gc2 gc1 )

    else
        ( NullGameComponentMsg, NullGameComponentMsg )



-- Send information to gc1


genInterFromOneSide : GameComponent -> GameComponent -> GameComponentTMsg
genInterFromOneSide gc1 gc2 =
    let
        op =
            gc1.data.position

        tp =
            gc2.data.position

        origin =
            gc1.data.collisionbox

        target =
            gc2.data.collisionbox

        result =
            List.foldl
                (\x o ->
                    o ++ List.filter (\y -> judgeCollision (getBoxPos op x) (getBoxPos tp y)) target
                )
                []
                origin
    in
    if result == [] then
        NullGameComponentMsg

    else
        GameInterCollisionMsg gc2.name
            gc2.data
            result
