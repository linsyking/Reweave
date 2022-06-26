module Common exposing (Model, Sound(..), SoundState(..), audio, initGlobalData)

import Audio exposing (Audio, AudioData)
import Base exposing (..)
import Constants exposing (..)
import Lib.Scene.Base exposing (..)
import Scenes.SceneSettings exposing (..)
import Time


type alias Model =
    { currentData : SceneDataTypes --- Writable
    , currentScene : SceneCT --- Readonly
    , currentGlobalData : GlobalData
    , time : Int --- Readonly
    , sound : Sound
    , soundState : SoundState
    }


type Sound
    = NoSound
    | CurrentSound Audio.Source


type SoundState
    = NotPlaying
    | Playing Time.Posix


initGlobalData : GlobalData
initGlobalData =
    { browserViewPort = ( 1280, 720 )
    , realHeight = 720
    , realWidth = 1280
    , startLeft = 0
    , startTop = 0
    , audioVolume = 0.5
    }


audio : AudioData -> Model -> Audio
audio _ model =
    case model.soundState of
        Playing t ->
            case model.sound of
                CurrentSound cs ->
                    Audio.audio cs t
                        |> Audio.scaleVolume model.currentGlobalData.audioVolume

                _ ->
                    Audio.silence

        _ ->
            Audio.silence
