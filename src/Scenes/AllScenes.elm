module Scenes.AllScenes exposing (allScenes)

{-| This is the doc for this module

This module records all the scenes.

@docs allScenes

-}

import Lib.CoreEngine.Global as CEG
import Scenes.End.Export as End
import Scenes.Home.Export as H
import Scenes.Home.Global as HG
import Scenes.Level0.Export as Level0
import Scenes.Level1.Export as Level1
import Scenes.Level2.Export as Level2
import Scenes.Level3.Export as Level3
import Scenes.Level4.Export as LV4
import Scenes.Level4boss.Export as Level4boss
import Scenes.Level5.Export as Level5
import Scenes.Level5boss.Export as Level5boss
import Scenes.Path.Export as Path
import Scenes.SceneSettings exposing (..)


{-| allScenes
-}
allScenes : List ( String, SceneCT )
allScenes =
    [ ( "Home", HG.toCT H.scene )
    , ( "Level2", CEG.toCT Level2.scene )
    , ( "Level4", CEG.toCT LV4.scene )
    , ( "Level0", CEG.toCT Level0.scene )
    , ( "Level1", CEG.toCT Level1.scene )
    , ( "Level3", CEG.toCT Level3.scene )
    , ( "Level4boss", CEG.toCT Level4boss.scene )
    , ( "Level5boss", CEG.toCT Level5boss.scene )
    , ( "Level5", CEG.toCT Level5.scene )
    , ( "Path", CEG.toCT Path.scene )
    , ( "End", CEG.toCT End.scene )
    ]
