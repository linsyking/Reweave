module Lib.Render.Render exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Point, Renderable, text, texture)
import Canvas.Settings exposing (Setting, fill)
import Canvas.Settings.Advanced exposing (scale, transform, translate)
import Canvas.Settings.Text exposing (TextAlign(..), align, font)
import Canvas.Texture exposing (Texture, dimensions, sprite)
import Color exposing (Color)
import Dict exposing (Dict)
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (brickSize)
import Lib.Resources.Base exposing (igetSprite)


transPoint : GlobalData -> ( Int, Int ) -> Point
transPoint gd p =
    posToReal gd p


renderSprite : GlobalData -> List Setting -> ( Int, Int ) -> ( Int, Int ) -> String -> Renderable
renderSprite gd ls p ( w, h ) name =
    let
        dst =
            gd.sprites
    in
    case igetSprite name dst of
        Just t ->
            let
                text_dim =
                    dimensions t

                rw =
                    widthToReal gd w

                rh =
                    heightToReal gd h

                text_width =
                    text_dim.width

                text_height =
                    text_dim.height

                width_s =
                    rw / text_width

                height_s =
                    rh / text_height

                ( newx, newy ) =
                    transPoint gd p
            in
            if w > 0 && h > 0 then
                texture
                    (transform
                        [ translate newx newy
                        , scale width_s height_s
                        ]
                        :: ls
                    )
                    ( 0, 0 )
                    t

            else if w > 0 && h <= 0 then
                texture
                    (transform
                        [ translate newx newy
                        , scale width_s width_s
                        ]
                        :: ls
                    )
                    ( 0, 0 )
                    t

            else if w <= 0 && h > 0 then
                texture
                    (transform
                        [ translate newx newy
                        , scale height_s height_s
                        ]
                        :: ls
                    )
                    ( 0, 0 )
                    t

            else
                -- All <= 0
                texture
                    ls
                    ( newx, newy )
                    t

        Nothing ->
            text [] (transPoint gd p) "Wrong Sprite"


renderBrickSheet : GlobalData -> List Setting -> ( Int, Int ) -> ( Int, Int ) -> String -> Dict String Texture -> Renderable
renderBrickSheet gd ls p ( x, y ) name dst =
    case igetSprite name dst of
        Just t ->
            let
                rw =
                    widthToReal gd brickSize

                rh =
                    heightToReal gd brickSize

                ( newx, newy ) =
                    transPoint gd p

                thisTexture =
                    sprite { x = toFloat x * 32, y = toFloat y * 32, width = 32, height = 32 } t

                w_s =
                    rw / 32

                h_s =
                    rh / 32
            in
            texture
                (transform
                    [ translate newx newy
                    , scale w_s h_s
                    ]
                    :: ls
                )
                ( 0, 0 )
                thisTexture

        Nothing ->
            text [] (transPoint gd p) "Wrong Sprite"


renderText : GlobalData -> Int -> String -> String -> ( Int, Int ) -> Renderable
renderText gd size s ft ( x, y ) =
    let
        rx =
            heightToReal gd size

        ( dsx, dsy ) =
            posToReal gd ( x, y )
    in
    text
        [ font { size = floor rx, family = ft }
        , align Start
        ]
        ( dsx, dsy + rx - 1 )
        s


renderTextWithColor : GlobalData -> Int -> String -> String -> Color -> ( Int, Int ) -> Renderable
renderTextWithColor gd size s ft col ( x, y ) =
    let
        rx =
            heightToReal gd size

        ( dsx, dsy ) =
            posToReal gd ( x, y )
    in
    text
        [ font { size = floor rx, family = ft }
        , align Start
        , fill col
        ]
        ( dsx, dsy + rx - 1 )
        s
