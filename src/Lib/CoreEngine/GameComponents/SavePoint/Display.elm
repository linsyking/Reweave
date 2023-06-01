module Lib.CoreEngine.GameComponents.SavePoint.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetbool, dgetint)
import Lib.Render.Render exposing (renderSprite, renderText)


{-| view
-}
view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        alive =
            dgetbool d.extra "Alive"

        fir =
            dgetint d.extra "firsttouchtime"

        ( px, py ) =
            d.position
    in
    [ ( group []
            [ renderSprite
                gd
                []
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                (if not alive then
                    "ot/save"

                 else
                    "ot/unsave"
                )
            ]
      , -1
      )
    , ( if t - fir <= 120 && t > 0 then
            if t - fir <= 50 then
                renderText gd 30 "Saved" "Times New Roman" (getPositionUnderCamera ( px, py - 30 ) ggd)

            else
                group [ alpha (toFloat (70 - (t - fir - 50)) / 70) ] [ renderText gd 30 "Saved" "Times New Roman" (getPositionUnderCamera ( px, py - 30 ) ggd) ]

        else
            group [] []
      , -1
      )
    ]
