module Common exposing (Model, audio, initGlobalData)

import Audio exposing (Audio, AudioData)
import Base exposing (..)
import Constants exposing (..)
import Dict
import Lib.Audio.Audio exposing (getAudio)
import Lib.Audio.Base exposing (AudioRepo)
import Lib.Scene.Base exposing (..)
import Scenes.SceneSettings exposing (..)


type alias Model =
    { currentData : SceneDataTypes --- Writable
    , currentScene : SceneCT --- Readonly
    , currentGlobalData : GlobalData
    , time : Int --- Readonly
    , audiorepo : AudioRepo
    }


initGlobalData : GlobalData
initGlobalData =
    { browserViewPort = ( 1280, 720 )
    , realHeight = 720
    , realWidth = 1280
    , startLeft = 0
    , startTop = 0
    , audioVolume = 0.5
    , sprites = Dict.empty
    }


audio : AudioData -> Model -> Audio
audio ad model =
    Audio.group (getAudio ad model.audiorepo)
        |> Audio.scaleVolume model.currentGlobalData.audioVolume
