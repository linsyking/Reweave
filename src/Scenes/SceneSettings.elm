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
import Scenes.Scene1.Export as S1



--- Set Scenes


{-| SceneDataTypes
-}
type SceneDataTypes
    = S1DataT S1.Data
    | HDataT H.Data
    | CoreEngineDataT CoreEngine.Data
    | NullSceneData


{-| SceneCT
-}
type alias SceneCT =
    Scene SceneDataTypes


{-| nullSceneCT
-}
nullSceneCT : SceneCT
nullSceneCT =
    { init = \_ _ -> NullSceneData
    , update = \_ g ( _, _ ) -> ( NullSceneData, NullSceneOutputMsg, g )
    , view = \_ _ -> group [] []
    }
