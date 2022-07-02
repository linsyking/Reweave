module Lib.CoreEngine.GameLayer.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( _, _ ) _ _ =
    group [] []
