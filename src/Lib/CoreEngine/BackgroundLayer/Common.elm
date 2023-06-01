module Lib.CoreEngine.BackgroundLayer.Common exposing (Model)

{-| This is the doc for this module

@docs Model

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)


{-| Model
-}
type alias Model =
    { render : Int -> GameGlobalData -> GlobalData -> Renderable }
