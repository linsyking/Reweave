module Lib.CoreEngine.FrontgroundLayer.Base exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component)
import Lib.CoreEngine.Base exposing (GameGlobalData)


type alias CTInfo =
    { components : Array Component
    , timeseries : Int -> GameGlobalData -> GlobalData -> Renderable
    }
