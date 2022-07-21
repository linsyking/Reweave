module Lib.Render.Character exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Render.Render exposing (renderSpriteWithRev)



-- Render characters


renderCharacterMove : Bool -> Int -> GlobalData -> ( Int, Int ) -> Renderable
renderCharacterMove rev st gd ( px, py ) =
    if st >= 0 then
        renderSpriteWithRev rev gd [] ( px - 30, py + 5 ) ( 130, 0 ) ("p_m" ++ String.fromInt st)

    else
        renderSpriteWithRev rev gd [] ( px - 30, py ) ( 130, 0 ) "p_stand"


renderCharacterInAir : Bool -> Bool -> GlobalData -> ( Int, Int ) -> Renderable
renderCharacterInAir sta rev gd ( px, py ) =
    if sta then
        -- Move upwardws
        renderSpriteWithRev rev gd [] ( px - 30, py + 5 ) ( 130, 0 ) "p_jump"

    else if rev then
        renderSpriteWithRev rev gd [] ( px - 60, py + 5 ) ( 130, 0 ) "p_fall"

    else
        renderSpriteWithRev rev gd [] ( px - 10, py + 5 ) ( 130, 0 ) "p_fall"
