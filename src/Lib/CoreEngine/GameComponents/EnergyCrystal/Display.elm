module Lib.CoreEngine.GameComponents.EnergyCrystal.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.Render.Render exposing (renderSprite)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, _ ) ggd gd =
    case d.status of
        Dead _ ->
            []

        _ ->
            [ ( group []
                    [ renderSprite gd [] (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) "skull" ]
              , 0
              )
            ]
