module Scenes.Level5.Config exposing
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
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)
import Lib.CoreEngine.GameComponents.SavePoint.Export as Save
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Scenes.Level5.Map exposing (mapsize, mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "JiangNan  江南" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 1000, 1640 ))) Player.gameComponent

        -- initGameComponent t (GamePlayerInit (PlayerInit ( 568, 1768 ))) Player.gameComponent
        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        (List.append
            [ initGameComponent t (GameExitInit (ExitInit ( 0, 1840 ) "Level4boss" (CustomPlayerPosition ( 1996, 1928 )) 0 2)) Exit.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2190 ) HorUp 600 False 3)) Spike.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1450, 1860 ) 2000 True 4)) EnergyCrystal.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 6231, 1256 ) 5)) Save.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 6600, 1290 ) 2000 True 6)) EnergyCrystal.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 13900, 1640 ) 7)) Save.gameComponent
            , initGameComponent t (GameExitInit (ExitInit ( 14500, 1480 ) "Level5boss" DefaultPlayerPosition 0 8)) Exit.gameComponent
            , initGameComponent t (GameCutSceneInit (CutSceneInit ( 1300, 1000 ) ( 100, 1500 ) 9 teach True)) CutScene.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 1500, 1800 ) 10)) Save.gameComponent
            ]
            (makeqe t ( 1900, 1800 ) 3000 70 15 100)
        )


teach : List ( String, String )
teach =
    [ ( "bird", "Wait! Do you know how to glide in the air?" )
    , ( "p_profile", "Probably no..." )
    , ( "bird", "You have to learn this skill." )
    , ( "bird", "First, use energy on yourself to dash forwards." )
    , ( "bird", "Then, immediately jump." )
    , ( "bird", "You should also move right during the whole process." )
    , ( "bird", "Isn't it easy? Try it, and follow those energy crystals." )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * (mapsize - 1) - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> GameGlobalData
initGameGlobalData e col =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( mapsize, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level5"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 32, 1860 ) ggd) ( 32 * 26, 0 ) "jn/building"
      , BehindSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 1800, 2000 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindSolids
      )
    ]


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
