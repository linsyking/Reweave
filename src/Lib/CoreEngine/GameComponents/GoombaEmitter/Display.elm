module Lib.CoreEngine.GameComponents.GoombaEmitter.Display exposing (..)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.DefinedTypes.Parser exposing (dgetfloat)
import Lib.Render.Render exposing (renderSpriteWithRev)


{-| view
-}
view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, _ ) ggd gd =
    let
        model =
            d.extra

        gx =
            dgetfloat model "goombaVelocityX"

        ( px, py ) =
            d.position
    in
    [ ( renderSpriteWithRev (gx >= 0) gd [] (getPositionUnderCamera ( px + 20, py - 40 ) ggd) ( 100, 100 ) "ot/cave", -1 ) ]
