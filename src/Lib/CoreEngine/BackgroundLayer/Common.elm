module Lib.CoreEngine.BackgroundLayer.Common exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)


type alias Model =
    { render : Int -> GameGlobalData -> GlobalData -> Renderable }
