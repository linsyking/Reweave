module Scenes.Level5boss.Config exposing
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
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as EnergyCrystal
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameComponents.Trigger.Base exposing (TriggerInit)
import Lib.CoreEngine.GameComponents.Trigger.Export as Trigger
import Lib.CoreEngine.GameComponents.Turtle.Base exposing (TurtleInit)
import Lib.CoreEngine.GameComponents.Turtle.Export as Turtle
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Lib.Resources.Monster exposing (isInCollected)
import Scenes.Level5boss.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents _ =
    Array.empty


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 2000, 0 ))) Player.gameComponent
            initGameComponent t (GamePlayerInit (PlayerInit ( 400, 1800 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


gameComponentsList : Int -> List GameComponent
gameComponentsList t =
    List.append
        [ initGameComponent t (GameExitInit (ExitInit ( 40, 1740 ) "Level5" (CustomPlayerPosition ( 14400, 1544 )) 1 2)) Exit.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 48 * 32, 2050 ) 200 True 5)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 51 * 32, 2050 ) 200 True 6)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 54 * 32, 2050 ) 200 True 7)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 57 * 32, 2050 ) 200 True 9)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 60 * 32, 2050 ) 200 True 10)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 63 * 32, 2050 ) 200 True 11)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 66 * 32, 2050 ) 200 True 12)) EnergyCrystal.gameComponent
        ]
        [ initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 69 * 32, 2050 ) 200 True 13)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 72 * 32, 2050 ) 200 True 14)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 75 * 32, 2050 ) 200 True 15)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 78 * 32, 2050 ) 200 True 16)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 81 * 32, 2050 ) 200 True 17)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 84 * 32, 2050 ) 200 True 18)) EnergyCrystal.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2190 ) HorUp 100 False 19)) Spike.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 1900, 630 ) "Path" DefaultPlayerPosition 0 20)) Exit.gameComponent
        ]


{-| initActors
-}
initActors : Int -> List String -> Array GameComponent
initActors t cs =
    Array.fromList
        (gameComponentsList t
            ++ (if isInCollected "turtle" cs then
                    []

                else
                    [ initGameComponent t (GameTurtleInit (TurtleInit ( 1900, 850 ) 100 8)) Turtle.gameComponent
                    , initGameComponent t (GameCutSceneInit (CutSceneInit ( 21 * 32, 1800 ) ( 32 * 3, 100 ) 4 dialoguesStart True)) CutScene.gameComponent
                    , initGameComponent t (GameCutSceneInit (CutSceneInit ( 1900, 900 ) ( 2000, 1000 ) 100 dialoguesTurtle False)) CutScene.gameComponent
                    , initGameComponent t (GameSpikeInit (SpikeInit ( 25 * 32, 1770 ) VerRight 5 True 21)) Spike.gameComponent
                    , initGameComponent t (GameTriggerInit (TriggerInit ( 26 * 32, 1800 ) ( 30, 100 ) 8 "awake" 3)) Trigger.gameComponent
                    ]
               )
            ++ makeqe t ( 1040, 1370 ) 1880 800 30 200
        )


dialoguesStart : List ( String, String )
dialoguesStart =
    [ ( "fox", "This monster is very powerful." )
    , ( "fox", "It can emit fireballs." )
    , ( "fox", "And it has a high health value." )
    , ( "fox", "Hit it to decrease its health bar." )
    , ( "fox", "Good luck." )
    , ( "p_profile", "Thank you." )
    ]


dialoguesTurtle : List ( String, String )
dialoguesTurtle =
    [ ( "p_profile", "You are very strong, what's your name?" )
    , ( "turtle", "XuanGui. I live in water, but I can also fly." )
    , ( "p_profile", "You can no longer harm humans!" )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 700 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 99 - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.2 ), ( 0.4, 0.1 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col t =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 100, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level5boss"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    , ingameTime = t
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    []



-- , ( \gd ggd ->
--         renderSprite gd [] (getPositionUnderCamera ( 475, 1350 ) ggd) ( 100, 0 ) "master"
--   , BehindActors
--   )
-- , ( \gd ggd ->
--         renderSprite gd [] (getPositionUnderCamera ( 3497, 1470 ) ggd) ( 32 * 10, 0 ) "dh/bigrock"
--   , FrontSolids
--   )
-- , ( \gd ggd ->
--         renderSprite gd [] (getPositionUnderCamera ( 3497, 1770 ) ggd) ( 32 * 10, 0 ) "dh/bigrock"
--   , FrontSolids
--   )
-- , ( \gd ggd ->
--         renderSprite gd [] (getPositionUnderCamera ( 3497, 2070 ) ggd) ( 32 * 10, 0 ) "dh/bigrock"
--   , FrontSolids
--   )
-- []
-- ++ makemanywaves 4


makeqe : Int -> ( Float, Float ) -> Float -> Float -> Int -> Int -> List GameComponent
makeqe t ( x, y ) length height step startuid =
    List.map
        (\i ->
            let
                ang =
                    toFloat i / toFloat step

                ( rpx, rpy ) =
                    ( x + ang * length, y - 4 * height * ang + 4 * height * ang * ang )
            in
            initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( floor rpx, floor rpy ) 100 True (startuid + i))) EnergyCrystal.gameComponent
        )
        (List.range 0 (step - 1))


{-| makemanywaves
-}
makemanywaves : Int -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
makemanywaves n =
    List.foldl
        (\i al ->
            al
                ++ [ ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( 450 + 770 * i, 2135 ) ggd) ( 800, 0 ) "bm/smallwave"
                     , FrontSolids
                     )
                   ]
        )
        []
        (List.range 0 (n - 1))
