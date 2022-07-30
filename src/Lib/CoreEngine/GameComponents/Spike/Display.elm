module Lib.CoreEngine.GameComponents.Spike.Display exposing
    ( view
    , renderSingleSpike
    )

{-| This is the doc for this module

@docs view

@docs renderSingleSpike

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.DefinedTypes.Parser exposing (dgetbool, dgetint)
import Lib.Render.Render exposing (renderSprite)


{-| view
-}
view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, _ ) ggd gd =
    let
        npn =
            dgetint d.extra "number"

        ndir =
            dgetint d.extra "direction"

        vis =
            dgetbool d.extra "visible"
    in
    if not vis then
        []

    else
        [ ( group []
                (List.map (\k -> renderSingleSpike d ggd gd ndir k) (List.range 0 (npn - 1)))
          , 0
          )
        ]


{-| renderSingleSpike
-}
renderSingleSpike : Data -> GameGlobalData -> GlobalData -> Int -> Int -> Renderable
renderSingleSpike d ggd gd dir num =
    let
        ( px, py ) =
            d.position
    in
    case dir of
        0 ->
            let
                startx =
                    32 * num
            in
            renderSprite gd [] (getPositionUnderCamera ( px + startx, py ) ggd) ( 32, 20 ) "spikeT"

        1 ->
            let
                startx =
                    32 * num
            in
            renderSprite gd [] (getPositionUnderCamera ( px + startx, py ) ggd) ( 32, 20 ) "spikeB"

        2 ->
            let
                startx =
                    32 * num
            in
            renderSprite gd [] (getPositionUnderCamera ( px, py + startx ) ggd) ( 20, 32 ) "spikeL"

        3 ->
            let
                startx =
                    32 * num
            in
            renderSprite gd [] (getPositionUnderCamera ( px, py + startx ) ggd) ( 20, 32 ) "spikeR"

        _ ->
            group [] []
