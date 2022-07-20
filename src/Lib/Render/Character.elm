module Lib.Render.Character exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.Render.Render exposing (renderSpriteWithRev)



-- Render characters


renderCharacterMove : Bool -> Int -> GlobalData -> ( Int, Int ) -> Renderable
renderCharacterMove rev st gd ( px, py ) =
    renderSpriteWithRev rev gd [] ( px - 30, py + 5 ) ( 130, 0 ) ("p_m" ++ String.fromInt st)


renderCharacterInAir : Bool -> Bool -> GlobalData -> ( Int, Int ) -> Renderable
renderCharacterInAir sta rev gd ( px, py ) =
    if sta then
        -- Move upwardws
        renderSpriteWithRev rev gd [] ( px - 30, py + 5 ) ( 130, 0 ) "p_jump"

    else
        renderSpriteWithRev rev gd [] ( px - 30, py + 5 ) ( 130, 0 ) "p_fall"
