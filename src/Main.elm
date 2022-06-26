port module Main exposing (..)

import Audio exposing (AudioCmd, AudioData)
import Base exposing (..)
import Browser.Events exposing (onKeyDown, onKeyUp, onResize)
import Common exposing (..)
import Html exposing (Html)
import Json.Decode as Decode
import Json.Encode as Encode
import Lib.Coordinate.Coordinates exposing (getStartPoint, maxHandW)
import Lib.Layer.Base exposing (LayerMsg(..))
import Lib.Scene.Base exposing (..)
import Lib.Scene.SceneLoader exposing (getCurrentScene, loadSceneByName)
import Scenes.SceneSettings exposing (..)
import Task
import Time


port audioPortToJS : Encode.Value -> Cmd msg


port audioPortFromJS : (Decode.Value -> msg) -> Sub msg


initModel : Model
initModel =
    { currentData = NullSceneData
    , currentScene = nullSceneCT
    , currentGlobalData = initGlobalData
    , time = 0
    , sound = NoSound
    , soundState = NotPlaying
    }


main : Program Flags (Audio.Model Msg Model) (Audio.Msg Msg)
main =
    Audio.elementWithAudio
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , audio = audio
        , audioPort = { toJS = audioPortToJS, fromJS = audioPortFromJS }
        }



--INIT


init : Flags -> ( Model, Cmd Msg, AudioCmd Msg )
init flags =
    let
        ms =
            loadSceneByName initModel "Scene1" NullSceneMsg

        oldgd =
            ms.currentGlobalData

        ( gw, gh ) =
            maxHandW ( flags.windowWidth, flags.windowHeight )

        ( fl, ft ) =
            getStartPoint ( flags.windowWidth, flags.windowHeight )

        newgd =
            { oldgd | browserViewPort = ( flags.windowWidth, flags.windowHeight ), realWidth = gw, realHeight = gh, startLeft = fl, startTop = ft }
    in
    ( { ms | currentGlobalData = newgd }, Cmd.none, Audio.loadAudio SoundLoaded "" )



--UPDATE


update : AudioData -> Msg -> Model -> ( Model, Cmd Msg, AudioCmd Msg )
update _ msg model =
    case msg of
        SoundLoaded result ->
            case result of
                Ok sound ->
                    ( { model | sound = CurrentSound sound }
                    , Task.perform PlaySoundGotTime Time.now
                    , Audio.cmdNone
                    )

                Err _ ->
                    ( model
                    , Cmd.none
                    , Audio.cmdNone
                    )

        PlaySoundGotTime t ->
            ( { model | soundState = Playing t }, Cmd.none, Audio.cmdNone )

        NewWindowSize t ->
            let
                oldgd =
                    model.currentGlobalData

                ( gw, gh ) =
                    maxHandW t

                ( fl, ft ) =
                    getStartPoint t

                newgd =
                    { oldgd | browserViewPort = t, realWidth = gw, realHeight = gh, startLeft = fl, startTop = ft }
            in
            ( { model | currentGlobalData = newgd }, Cmd.none, Audio.cmdNone )

        _ ->
            let
                cs =
                    getCurrentScene model

                cd =
                    model.currentData

                cm =
                    ( cd, model.time )

                ( sdt, som ) =
                    cs.update msg cm

                ntmodel =
                    { model | time = model.time + 1 }

                tmodel =
                    case msg of
                        Tick _ ->
                            ntmodel

                        _ ->
                            model

                bnewmodel =
                    { tmodel | currentData = sdt }
            in
            case som of
                ChangeScene ( tm, s ) ->
                    --- Load new scene
                    ( loadSceneByName tmodel s tm, Cmd.none, Audio.cmdNone )

                PlaySound s ->
                    ( bnewmodel, Cmd.none, Audio.loadAudio SoundLoaded s )

                SetSound s ->
                    let
                        oldgd =
                            bnewmodel.currentGlobalData

                        newgd =
                            { oldgd | audioVolume = s }
                    in
                    ( { bnewmodel | currentGlobalData = newgd }, Cmd.none, Audio.cmdNone )

                NullSceneOutputMsg ->
                    ( bnewmodel, Cmd.none, Audio.cmdNone )


subscriptions : AudioData -> Model -> Sub Msg
subscriptions _ _ =
    Sub.batch
        [ Time.every 15 Tick --- Slow down the fps
        , onKeyDown (Decode.map (\x -> KeyDown x) (Decode.field "keyCode" Decode.int))
        , onKeyUp (Decode.map (\x -> KeyUp x) (Decode.field "keyCode" Decode.int))
        , onResize (\w h -> NewWindowSize ( w, h ))
        ]


view : AudioData -> Model -> Html Msg
view _ model =
    (getCurrentScene model).view ( model.currentData, model.time ) model.currentGlobalData
