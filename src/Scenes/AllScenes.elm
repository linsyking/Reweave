module Scenes.AllScenes exposing (allScenes)

import Lib.CoreEngine.Export as CE
import Lib.CoreEngine.Global as CEG
import Scenes.Home.Export as H
import Scenes.Home.Global as HG
import Scenes.Level1.Export as LV1
import Scenes.Level2.Export as Level2
import Scenes.Scene1.Export as S1
import Scenes.Scene1.Global as S1G
import Scenes.SceneSettings exposing (..)


allScenes : List ( String, SceneCT )
allScenes =
    [ ( "Scene1", S1G.toCT S1.scene )
    , ( "Engine", CEG.toCT CE.scene )
    , ( "Level1", CEG.toCT LV1.scene )
    , ( "Home", HG.toCT H.scene )
    , ( "Level2", CEG.toCT Level2.scene )
    ]
