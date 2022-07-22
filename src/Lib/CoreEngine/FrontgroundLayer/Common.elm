module Lib.CoreEngine.FrontgroundLayer.Common exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Scene.Base exposing (EngineT)


type alias Model =
    { render : Int -> GameGlobalData -> GlobalData -> Renderable
    , components : Array Component
    , fpsrepo : List Int
    , ispaused : Bool
    , exitinfo : EngineT
    }
