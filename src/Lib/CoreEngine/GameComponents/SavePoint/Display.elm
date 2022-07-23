module Lib.CoreEngine.GameComponents.SavePoint.Display exposing (view)

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
        alive =
            dgetbool d.extra "Alive"
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
    ]
