module Scenes.Level4.Config exposing
    ( initFrontGroundComponents
    , initPlayer
    , initActors
    , initCamera
    , initGameGlobalData
    , allChartlets
    )

{-| This is the doc for this module

@docs initFrontGroundComponents

@docs initPlayer

@docs initActors

@docs initCamera

@docs initGameGlobalData

@docs allChartlets

-}

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Components.Hints.Export as Hints
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
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)
import Lib.CoreEngine.GameComponents.SavePoint.Export as Save
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Scenes.Level4.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "DongHai  东海" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 326, 2056 ))) Player.gameComponent

        -- initGameComponent t (GamePlayerInit (PlayerInit ( 6014, 2056 ))) Player.gameComponent
        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameGoombaInit (GoombaInit ( 3360, 1696 ) ( 0, 0 ) 50 2)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 4416, 1696 ) ( 0, 0 ) 50 3)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 4416, 1800 ) ( 0, 0 ) 50 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 5300, 1800 ) ( 0, 0 ) 50 5)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 832, 1600 ) ( 0, 0 ) 50 6)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1280, 1696 ) ( 0, 0 ) 50 7)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1760, 1800 ) ( 0, 0 ) 50 8)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 2240, 1800 ) ( 0, 0 ) 50 9)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 3840, 2080 ) ( 0, 0 ) 50 15)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 4160, 2080 ) ( 0, 0 ) 50 16)) Goomba.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 30, 2000 ) "Level3" (CustomPlayerPosition ( 4413, 1608 )) 0 98)) Exit.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 5690, 1920 ) "Level4boss" DefaultPlayerPosition 0 99)) Exit.gameComponent

        --, initGameComponent t (GameCutSceneInit (CutSceneInit ( 100, 1800 ) ( 100, 160 ) 88 [ ( "1", "Dear master, I want learn something from you", True ), ( "1", "Yes, please go ahead.", False ) ])) CutScene.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 672, 2060 ) HorUp 2 True 12)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 1568, 2060 ) HorUp 3 True 13)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 3360, 1408 ) HorDown 11 True 10)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 3232, 2120 ) HorUp 15 True 11)) Spike.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3900, 1880 ) 200 False 17)) EnergyCrystal.gameComponent
        , initGameComponent t (GameCutSceneInit (CutSceneInit ( 5420, 2130 ) ( 100, 32 ) 18 fishtalk True)) CutScene.gameComponent
        , initGameComponent t (GameSavePointInit (SavePointInit ( 2927, 1320 ) 19)) Save.gameComponent
        , initGameComponent t (GameSavePointInit (SavePointInit ( 5258, 2056 ) 20)) Save.gameComponent

        -- , initGameComponent t (GameFishInit (FishInit ( 5632, 100 ) ( 0, 0 ) "default" 100 12)) Monster.gameComponent
        ]


fishtalk : List ( String, String )
fishtalk =
    [ ( "p_profile", "What are those scales?" )
    , ( "p_profile", "Is there a big fish?" )
    , ( "fox", "I know this! It's Luoyu!" )
    , ( "p_profile", "Wow! Who is Luoyu?" )
    , ( "fox", "It is a large fish that can emit scales." )
    , ( "fox", "It has killed millions of creatures." )
    , ( "p_profile", "I should be more careful." )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 199 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> GameGlobalData
initGameGlobalData e col =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 200, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level4"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2740, 1830 ) ggd) ( 32 * 16, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2740, 1530 ) ggd) ( 32 * 12, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2800, 1420 ) ggd) ( 32 * 11, 0 ) "dh/rock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2900, 1420 ) ggd) ( 32 * 11, 0 ) "dh/rock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 5464, 2130 ) ggd) ( 32, 0 ) "ot/scale"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 5420, 2140 ) ggd) ( 32, 0 ) "ot/scale"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 5440, 2130 ) ggd) ( 32, 0 ) "ot/scale"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 5480, 2140 ) ggd) ( 32, 0 ) "ot/scale"
      , BehindActors
      )
    ]
        ++ makemanywaves ( 0, 2150 ) 8


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
