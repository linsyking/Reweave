module Lib.CoreEngine.FrontgroundLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (alpha)
import Color exposing (black)
import Lib.Component.ComponentHandler exposing (genView)
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.Render.Render exposing (renderText)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, t ) ggd gd =
    group []
        [ genView gd t model.components
        , model.render t ggd gd
        , genFPS model gd
        , if ggd.ingamepause then
            shapes [ fill black, alpha 0.5 ] [ rect (posToReal gd ( 0, 0 )) (widthToReal gd 1920) (heightToReal gd 1080) ]

          else
            group [] []
        ]


genFPS : Model -> GlobalData -> Renderable
genFPS model gd =
    let
        ( begin, end ) =
            case List.head model.fpsrepo of
                Just x ->
                    case List.head (List.reverse model.fpsrepo) of
                        Just y ->
                            ( x, y )

                        Nothing ->
                            ( 0, 0 )

                Nothing ->
                    ( 0, 0 )

        oneframe =
            toFloat (end - begin) / 9

        fps =
            floor (1000 / oneframe)
    in
    if oneframe == 0 then
        group [] []

    else
        group [ alpha 0.3 ] [ renderText gd 20 ("FPS:" ++ String.fromInt fps) "sans-serif" ( 1850, 0 ) ]
