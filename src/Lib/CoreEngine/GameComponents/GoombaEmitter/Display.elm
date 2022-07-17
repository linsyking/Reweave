module Lib.CoreEngine.GameComponents.GoombaEmitter.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( _, _ ) _ _ =
    group [] []
