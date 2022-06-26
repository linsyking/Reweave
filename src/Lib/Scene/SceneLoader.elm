module Lib.Scene.SceneLoader exposing (..)

import Common exposing (..)
import Html exposing (i)
import Lib.Scene.Base exposing (SceneMsg)
import List exposing (head)
import Scenes.AllScenes exposing (allScenes)
import Scenes.SceneSettings exposing (..)



-- import Scenes.Scene1.Export exposing (Scene1DataT)


getScene : String -> SceneCT
getScene i =
    let
        scenes =
            allScenes

        tests =
            List.filter (\( x, _ ) -> x == i) scenes

        head =
            List.head tests
    in
    case head of
        Just ( _, x ) ->
            x

        Nothing ->
            nullSceneCT


loadScene : Model -> SceneCT -> SceneMsg -> Model
loadScene model cs tm =
    let
        ls =
            { model | currentScene = cs }

        ld =
            { ls | currentData = cs.init ls.time tm }
    in
    ld


loadSceneByName : Model -> String -> SceneMsg -> Model
loadSceneByName model i tm =
    let
        sc =
            getScene i
    in
    loadScene model sc tm


getCurrentScene : Model -> SceneCT
getCurrentScene model =
    model.currentScene
