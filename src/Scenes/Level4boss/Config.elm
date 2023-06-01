module Scenes.Level4boss.Config exposing
    ( initFrontGroundComponents
    , initPlayer
    , initActors
    , initCamera
    , initGameGlobalData
    , allChartlets
    , makemanywaves
    )

{-| This is the doc for this module

@docs initFrontGroundComponents

@docs initPlayer

@docs initActors

@docs initCamera

@docs initGameGlobalData

@docs allChartlets

@docs makemanywaves

-}

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Bullet.Base exposing (BulletInit)
import Lib.CoreEngine.GameComponents.Bullet.Export as Bullet
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as EnergyCrystal
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Fish.Base exposing (FishInit)
import Lib.CoreEngine.GameComponents.Fish.Export as Fish
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameComponents.Trigger.Base exposing (TriggerInit)
import Lib.CoreEngine.GameComponents.Trigger.Export as Trigger
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Lib.Resources.Monster exposing (isInCollected)
import Scenes.Level4boss.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents _ =
    Array.fromList
        [--     Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "Beiming  北溟" ])
         -- , Hints.initComponent t (ComponentLStringMsg [ "40", "1580", "100", "35", "Near The River 小河边" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 3197, 1480 ))) Player.gameComponent
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 1600, 300 ))) Player.gameComponent
            initGameComponent t (GamePlayerInit (PlayerInit ( 300, 1800 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


gameComponentsList : Int -> List GameComponent
gameComponentsList t =
    [ initGameComponent t (GameExitInit (ExitInit ( 40, 1740 ) "Level4" (CustomPlayerPosition ( 5940, 2056 )) 1 2)) Exit.gameComponent

    -- , initGameComponent t (GameCutSceneInit (CutSceneInit ( 475, 1340 ) ( 100, 100 ) 5 dialoguesMaster True)) CutScene.gameComponent
    -- , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2200 ) HorUp 1000 False 3)) Spike.gameComponent
    , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2190 ) HorUp 200 False 4)) Spike.gameComponent

    -- , initGameComponent t (GameExitInit (ExitInit ( 3700, 1450 ) "Level2" DefaultPlayerPosition 0 7)) Exit.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 25 * 32 + 1200, 2000 ) 400 True 9)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 25 * 32 + 600, 1700 ) 400 True 10)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 25 * 32 + 1000, 2000 ) 400 True 11)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 25 * 32 + 1400, 2000 ) 400 True 12)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 36 * 32, 1840 ) 100 True 14)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 79 * 32, 32 * 58 ) 200 True 16)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 79 * 32, 32 * 58 ) 200 True 17)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 83 * 32, 32 * 48 ) 400 True 18)) EnergyCrystal.gameComponent
    , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 96 * 32, 32 * 43 ) 2000 True 19)) EnergyCrystal.gameComponent
    , initGameComponent t (GameExitInit (ExitInit ( 1920, 1500 ) "Level5" DefaultPlayerPosition 0 60)) Exit.gameComponent
    ]


{-| initActors
-}
initActors : Int -> List String -> Array GameComponent
initActors t cs =
    Array.fromList
        (gameComponentsList t
            ++ (if isInCollected "fish" cs then
                    []

                else
                    List.append
                        [ initGameComponent t (GameFishInit (FishInit ( 1600, 800 ) 100 8)) Fish.gameComponent
                        , initGameComponent t (GameCutSceneInit (CutSceneInit ( 16 * 32, 1800 ) ( 32 * 3, 100 ) 15 dialoguesFishB True)) CutScene.gameComponent
                        , initGameComponent t (GameTriggerInit (TriggerInit ( 20 * 32, 1800 ) ( 30, 100 ) 8 "awake" 13)) Trigger.gameComponent
                        , initGameComponent t (GameSpikeInit (SpikeInit ( 19 * 32, 1770 ) VerRight 5 True 300)) Spike.gameComponent
                        , initGameComponent t (GameCutSceneInit (CutSceneInit ( 1600, 900 ) ( 2000, 1000 ) 100 dialoguesFishA False)) CutScene.gameComponent
                        ]
                        (makecircleScales t ( 2010, 1600 ) 120 15 20 ++ makecircleScales t ( 2010, 1600 ) 150 10 40)
               )
        )


dialoguesFishB : List ( String, String )
dialoguesFishB =
    [ ( "fish", "Who are you?" )
    , ( "p_profile", "I'm here to reweave you into the scroll!" )
    , ( "fish", "Hmm, you can't!" )
    ]


dialoguesFishA : List ( String, String )
dialoguesFishA =
    [ ( "p_profile", "You are strong. Are you Luoyu?" )
    , ( "fish", "Yes. Please let me escape from the scroll!" )
    , ( "p_profile", "I won't let you harm humans!" )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 500 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.9 ), ( 0.4, 0.1 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> GameGlobalData
initGameGlobalData e col =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level4boss"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [] ++ makemanywaves ( 0, 2150 ) 8


{-| makemanywaves
-}
makemanywaves : ( Int, Int ) -> Int -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
makemanywaves ( sx, sy ) n =
    List.foldl
        (\i al ->
            al
                ++ [ ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( sx + 760 * i, sy ) ggd) ( 1200, 0 ) "dh/wave"
                     , FrontSolids
                     )
                   ]
        )
        []
        (List.range 0 (n - 1))


makecircleScales : Int -> ( Float, Float ) -> Float -> Int -> Int -> List GameComponent
makecircleScales t ( x, y ) r step startuid =
    List.map
        (\i ->
            let
                ang =
                    toFloat i / toFloat step * 2 * pi

                ( rpx, rpy ) =
                    ( x + r * cos ang, y + r * sin ang )
            in
            initGameComponent t (GameBulletInit (BulletInit ( floor rpx, floor rpy ) ( 0, 0 ) "ot/scale" (startuid + i))) Bullet.gameComponent
        )
        (List.range 0 (step - 1))
