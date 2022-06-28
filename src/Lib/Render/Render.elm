module Lib.Render.Render exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Point, Renderable, text, texture)
import Canvas.Settings exposing (Setting)
import Canvas.Settings.Advanced exposing (scale, transform, translate)
import Canvas.Settings.Text exposing (TextAlign(..), align, font)
import Canvas.Texture exposing (Texture, dimensions)
import Dict exposing (Dict)
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.Resources.Base exposing (igetSprite)


transPoint : GlobalData -> ( Int, Int ) -> Point
transPoint gd p =
    posToReal gd p


renderSprite : GlobalData -> List Setting -> ( Int, Int ) -> ( Int, Int ) -> String -> Dict String Texture -> Renderable
renderSprite gd ls p ( w, h ) name dst =
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
