module Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)

{-| This is the doc for this module

@docs Model

-}

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Scene.Base exposing (EngineT)


{-| Model
-}
type alias Model =
    { render : Int -> GameGlobalData -> GlobalData -> Renderable
    , components : Array Component
    , fpsrepo : List Int
    , ispaused : Bool
    , exitinfo : EngineT
    , savePoint : Maybe ( Int, Int )
    }
