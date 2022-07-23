module Scenes.Level3.Config exposing
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
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)
import Lib.CoreEngine.GameComponents.Bone.Export as Bone
import Lib.CoreEngine.GameComponents.Ball.Base exposing (BallInit)
import Lib.CoreEngine.GameComponents.Ball.Export as Ball
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as EnergyCrystal
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Export as GoombaEmitter
import Lib.CoreEngine.GameComponents.Monster.Base exposing (MonsterInit)
import Lib.CoreEngine.GameComponents.Monster.Export as Monster
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Scenes.Level3.Map exposing (mymap)
import Lib.Render.Render exposing (renderSprite)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)

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
            initGameComponent t (GamePlayerInit (PlayerInit ( 400, 2000 ))) Player.gameComponent

        --initGameComponent t (GamePlayerInit (PlayerInit ( 3744, 2000 ))) Player.gameComponent
        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameExitInit (ExitInit ( 10, 2010 ) "Level2" (CustomPlayerPosition ( 3536, 1384 )) 0 6)) Exit.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 640, 2100 ) 150 8)) Bone.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 1265, 2100 ) 150 8)) Bone.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 1417, 2100 ) 150 8)) Bone.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1240, 1900 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1240, 1700 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1240, 1500 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1824, 1200 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 1700, 2120 ) 360 ( 50, 0 ) 13)) GoombaEmitter.gameComponent
        , initGameComponent t (GameBallInit (BallInit ( 2000, 1000 ) 100 8)) Ball.gameComponent
        , initGameComponent t (GameBallInit (BallInit ( 2230, 1000 ) 100 8)) Ball.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1900, 2100 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2000, 2100 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2100, 2100 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2300, 2100 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2400, 2100 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2500, 2100 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3520, 1800 ) 200 False 8)) EnergyCrystal.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 3296, 2000 ) 250 8)) Bone.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 3550, 2000 ) 250 8)) Bone.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 3800, 2000 ) 250 8)) Bone.gameComponent
        , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 2700, 2120 ) 360 ( -50, 0 ) 13)) GoombaEmitter.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1000, 2000 ) ( 50, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1100, 2000 ) ( -50, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1840, 1300 ) ( -50, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameMonsterInit (MonsterInit ( 4100, 1410 ) ( 400, 300 ) "fox" 21 20)) Monster.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 4500, 1500 ) "Level4" DefaultPlayerPosition 0 6)) Exit.gameComponent
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
    , currentScene = "Level3"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
                renderSprite gd [] (getPositionUnderCamera ( 300, 1760 ) ggd) ( 700, 0 ) "zy/building"
        , BehindActors )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2850, 1450 ) ggd) ( 32 * 14, 0 ) "dh/rock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2850, 1650 ) ggd) ( 32 * 14, 0 ) "dh/rock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2850, 1750 ) ggd) ( 32 * 14, 0 ) "dh/rock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2850, 1950 ) ggd) ( 32 * 14, 0 ) "dh/rock"
      , FrontSolids
      )
    ]
