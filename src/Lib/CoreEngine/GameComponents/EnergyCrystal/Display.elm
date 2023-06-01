module Lib.CoreEngine.GameComponents.EnergyCrystal.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetbool)
import Lib.Render.Render exposing (renderSprite)


{-| view
-}
view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, _ ) ggd gd =
    let
        isdead =
            not (dgetbool d.extra "isalive")

        irr =
            dgetbool d.extra "recover"
    in
    if isdead && not irr then
        []

    else
        [ ( group []
                [ renderSprite
                    gd
                    []
                    (getPositionUnderCamera d.position ggd)
                    ( d.simplecheck.width, d.simplecheck.height )
                    (if isdead then
                        "ot/crystaldead"

                     else
                        "ot/crystal"
                    )
                ]
          , 0
          )
        ]
