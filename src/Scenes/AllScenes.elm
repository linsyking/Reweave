module Scenes.AllScenes exposing (allScenes)

{-| This is the doc for this module

@docs allScenes

-}

import Lib.CoreEngine.Export as CE
import Lib.CoreEngine.Global as CEG
import Scenes.Home.Export as H
import Scenes.Home.Global as HG
import Scenes.Level0.Export as Level0
import Scenes.Level1.Export as Level1
import Scenes.Level2.Export as Level2
import Scenes.Level3.Export as Level3
import Scenes.Level4.Export as LV4
import Scenes.Level4boss.Export as Level4boss
import Scenes.Platformtest.Export as Platformtest
import Scenes.Scene1.Export as S1
import Scenes.Scene1.Global as S1G
import Scenes.SceneSettings exposing (..)
import Scenes.TestChamber.Export as TC


{-| allScenes
-}
allScenes : List ( String, SceneCT )
allScenes =
    [ ( "Scene1", S1G.toCT S1.scene )
    , ( "Engine", CEG.toCT CE.scene )
    , ( "Test", CEG.toCT TC.scene )
    , ( "Home", HG.toCT H.scene )
    , ( "Level2", CEG.toCT Level2.scene )
    , ( "Level4", CEG.toCT LV4.scene )
    , ( "Platformtest", CEG.toCT Platformtest.scene )
    , ( "Level0", CEG.toCT Level0.scene )
    , ( "Level1", CEG.toCT Level1.scene )
    , ( "Level3", CEG.toCT Level3.scene )
    , ( "Level4boss", CEG.toCT Level4boss.scene )

    ]
