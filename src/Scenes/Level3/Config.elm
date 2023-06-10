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
import Components.Hints.Export as Hints
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Ball.Base exposing (BallInit)
import Lib.CoreEngine.GameComponents.Ball.Export as Ball
import Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)
import Lib.CoreEngine.GameComponents.Bone.Export as Bone
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as EnergyCrystal
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Export as GoombaEmitter
import Lib.CoreEngine.GameComponents.Monster.Base exposing (MonsterInit)
import Lib.CoreEngine.GameComponents.Monster.Export as Monster
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)
import Lib.CoreEngine.GameComponents.SavePoint.Export as Save
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Lib.Resources.Monster exposing (isInCollected)
import Scenes.Level3.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "40", "1530", "30", "50", "ZhongYuan  中原" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 400, 2000 ))) Player.gameComponent

        -- initGameComponent t (GamePlayerInit (PlayerInit ( 3831, 1600 ))) Player.gameComponent
        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> List String -> Array GameComponent
initActors t cs =
    Array.fromList
        ([ initGameComponent t (GameExitInit (ExitInit ( 10, 2010 ) "Level2" (CustomPlayerPosition ( 4649, 936 )) 0 6)) Exit.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 620, 2100 ) 150 7)) Bone.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 1285, 2100 ) 150 8)) Bone.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 1417, 2100 ) 150 9)) Bone.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1240, 1900 ) 200 False 10)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1240, 1700 ) 200 False 11)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1240, 1500 ) 200 False 12)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1824, 1200 ) 200 False 13)) EnergyCrystal.gameComponent
         , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 1700, 2140 ) 360 ( 50, 0 ) 14)) GoombaEmitter.gameComponent
         , initGameComponent t (GameBallInit (BallInit ( 2000, 1000 ) 100 15)) Ball.gameComponent
         , initGameComponent t (GameBallInit (BallInit ( 2230, 1000 ) 100 16)) Ball.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 1900, 2100 ) 200 False 17)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2000, 2100 ) 200 False 18)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2100, 2100 ) 200 False 19)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2300, 2100 ) 200 False 20)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2400, 2100 ) 200 False 21)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2500, 2100 ) 200 False 22)) EnergyCrystal.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3520, 1800 ) 200 False 23)) EnergyCrystal.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 3296, 2000 ) 250 24)) Bone.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 3550, 2000 ) 250 25)) Bone.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 3800, 2000 ) 250 26)) Bone.gameComponent
         , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 2700, 2120 ) 360 ( -50, 0 ) 27)) GoombaEmitter.gameComponent
         , initGameComponent t (GameGoombaInit (GoombaInit ( 1000, 2000 ) ( 50, 0 ) 50 28)) Goomba.gameComponent
         , initGameComponent t (GameGoombaInit (GoombaInit ( 1100, 2000 ) ( -50, 0 ) 50 29)) Goomba.gameComponent
         , initGameComponent t (GameGoombaInit (GoombaInit ( 1840, 1300 ) ( -50, 0 ) 50 30)) Goomba.gameComponent
         , initGameComponent t (GameExitInit (ExitInit ( 4700, 1550 ) "Level4" DefaultPlayerPosition 0 32)) Exit.gameComponent
         , initGameComponent t (GameSavePointInit (SavePointInit ( 2883, 1352 ) 33)) Save.gameComponent
         ]
            ++ (if isInCollected "fox" cs then
                    []

                else
                    [ initGameComponent t (GameMonsterInit (MonsterInit ( 4100, 1310 ) ( 400, 400 ) True "fox" 35 31)) Monster.gameComponent
                    , initGameComponent t (GameCutSceneInit (CutSceneInit ( 4100, 1310 ) ( 400, 400 ) 35 foxtalks False)) CutScene.gameComponent
                    ]
               )
        )


foxtalks : List ( String, String )
foxtalks =
    [ ( "p_profile", "Hi, who are you?" )
    , ( "fox", "I am JiuWeiHu. I have nine tails." )
    , ( "fox", "I can eat humans." )
    , ( "p_profile", "But now you are in my scroll." )
    , ( "fox", "I know about many monsters, maybe I can help you." )
    , ( "p_profile", "Alright." )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 159 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col t =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 160, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level3"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    , ingameTime = t
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 10, 1760 ) ggd) ( 700, 0 ) "zy/building"
      , BehindActors
      )
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
