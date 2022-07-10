module Lib.CoreEngine.GameComponents.Player.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.Render.Render exposing (renderSprite)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( d, _ ) ggd gd =
    renderSprite gd [] (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) "background" gd.sprites
