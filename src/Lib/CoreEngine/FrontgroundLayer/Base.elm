module Lib.CoreEngine.FrontgroundLayer.Base exposing (CTInfo)

{-| This is the doc for this module

@docs CTInfo

-}

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component)
import Lib.CoreEngine.Base exposing (GameGlobalData)


{-| CTInfo
-}
type alias CTInfo =
    { components : Array Component
    , timeseries : Int -> GameGlobalData -> GlobalData -> Renderable
    }
