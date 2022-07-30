module Lib.CoreEngine.LayerSettings exposing
    ( LayerDataType(..)
    , LayerCT
    )

{-| This is the doc for this module

@docs LayerDataType

@docs LayerCT

-}

import Lib.CoreEngine.BackgroundLayer.Export as BGL
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Export as FGL
import Lib.CoreEngine.GameLayer.Export as GL
import Lib.Layer.Base exposing (Layer)


{-| LayerDataType
-}
type LayerDataType
    = FrontgroundData FGL.Data
    | BackgroundData BGL.Data
    | GameData GL.Data
    | NullLayerData


{-| LayerCT
-}
type alias LayerCT =
    Layer GameGlobalData LayerDataType
