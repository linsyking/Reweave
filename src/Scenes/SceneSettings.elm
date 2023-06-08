module Scenes.SceneSettings exposing
    ( SceneDataTypes(..)
    , SceneCT
    , nullSceneCT
    )

{-| This is the doc for this module

@docs SceneDataTypes

@docs SceneCT

@docs nullSceneCT

-}

import Base exposing (..)
import Canvas exposing (group)
import Lib.CoreEngine.Export as CoreEngine
import Lib.Scene.Base exposing (..)
import Scenes.Home.Export as H



--- Set Scenes


{-| SceneDataTypes

All the scene data types should be listed here.

`HdataT` is for Home Scene.

`CoreEngineDataT` is for the Core Engine Scene.

-}
type SceneDataTypes
    = HDataT H.Data
    | CoreEngineDataT CoreEngine.Data
    | NullSceneData


{-| SceneCT

SceneCT is a Scene with datatypes.

-}
type alias SceneCT =
    Scene SceneDataTypes


{-| nullSceneCT
-}
nullSceneCT : SceneCT
nullSceneCT =
    { init = \_ _ -> NullSceneData
    , update = \_ g ( _, _ ) -> ( NullSceneData, [], g )
    , view = \_ _ -> group [] []
    }
