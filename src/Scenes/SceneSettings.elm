module Scenes.SceneSettings exposing (SceneCT, SceneDataTypes(..), nullSceneCT)

import Base exposing (..)
import Canvas exposing (text)
import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Export as S1



--- Set Scenes


type SceneDataTypes
    = S1DataT S1.Data
    | NullSceneData


type alias SceneCT =
    Scene SceneDataTypes


nullSceneCT : SceneCT
nullSceneCT =
    { init = \_ _ -> NullSceneData
    , update = \_ ( _, _ ) -> ( NullSceneData, NullSceneOutputMsg )
    , view = \_ _ -> text [] ( 0, 0 ) ""
    }
