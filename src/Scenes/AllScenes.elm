module Scenes.AllScenes exposing (allScenes)

import Scenes.Scene1.Export as S1
import Scenes.Scene1.Global as S1G
import Scenes.SceneSettings exposing (..)


allScenes : List ( String, SceneCT )
allScenes =
    [ ( "Scene1", S1G.toCT S1.scene ) ]
