module Scenes.Level2.Config exposing
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
import Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)
import Lib.CoreEngine.GameComponents.Bone.Export as Bone
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as Energy
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
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Map.Longxi exposing (makemanybamboos)
import Lib.Render.Render exposing (renderSprite)
import Lib.Resources.Monster exposing (isInCollected)
import Scenes.Level2.Map exposing (mapwidth, mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "LongXi  陇西" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 128, 1864 ))) Player.gameComponent

        -- initGameComponent t (GamePlayerInit (PlayerInit ( 3814, 552 ))) Player.gameComponent
        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> List String -> Array GameComponent
initActors t cs =
    Array.fromList
        ([ initGameComponent t (GameGoombaInit (GoombaInit ( 800, 2100 ) ( 0, 0 ) 50 3)) Goomba.gameComponent
         , initGameComponent t (GameGoombaInit (GoombaInit ( 1500, 1750 ) ( 50, 0 ) 50 4)) Goomba.gameComponent
         , initGameComponent t (GameGoombaInit (GoombaInit ( 1550, 1750 ) ( -50, 0 ) 50 5)) Goomba.gameComponent
         , initGameComponent t (GameExitInit (ExitInit ( 4820, 880 ) "Level3" DefaultPlayerPosition 0 6)) Exit.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 590, 2183 ) HorUp 3 True 7)) Spike.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 1330, 2150 ) 150 8)) Bone.gameComponent
         , initGameComponent t (GameBoneInit (BoneInit ( 1460, 2150 ) 150 9)) Bone.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 46 * 32, 50 * 32 + 20 ) HorDown 2 True 10)) Spike.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 46 * 32, 50 * 32 - 20 ) HorUp 2 True 11)) Spike.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 32 * 50, 2190 ) HorUp 30 True 12)) Spike.gameComponent
         , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 32 * 94, 53 * 32 ) 360 ( -50, 0 ) 13)) GoombaEmitter.gameComponent
         , initGameComponent t (GameSavePointInit (SavePointInit ( 1924, 1320 ) 15)) Save.gameComponent
         , initGameComponent t (GameExitInit (ExitInit ( -20, 1820 ) "Level1" (CustomPlayerPosition ( 3536, 1384 )) 0 16)) Exit.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 32 * 5 + 5, 2000 ) VerRight 2 True 17)) Spike.gameComponent
         , initGameComponent t (GameSavePointInit (SavePointInit ( 3880, 360 ) 19)) Save.gameComponent
         , initGameComponent t (GameGoombaInit (GoombaInit ( 94 * 32, 35 * 32 ) ( 0, 0 ) 50 22)) Goomba.gameComponent
         , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 36 * 32 + 20, 62 * 32 - 60 ) 300 True 23)) Energy.gameComponent
         ]
            ++ (if isInCollected "lion" cs then
                    []

                else
                    [ initGameComponent t (GameMonsterInit (MonsterInit ( 4420, 120 ) ( 400, 300 ) False "lion" 21 20)) Monster.gameComponent
                    , initGameComponent t (GameCutSceneInit (CutSceneInit ( 4420, 120 ) ( 400, 300 ) 21 liontalkings False)) CutScene.gameComponent
                    ]
               )
        )


liontalkings : List ( String, String )
liontalkings =
    [ ( "p_profile", "Hi, who are you?" )
    , ( "lion", "I am TaoWu. A very strong monster." )
    , ( "p_profile", "But now you are in my scroll." )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * (mapwidth - 1) - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col t =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( mapwidth, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level2"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    , ingameTime = t
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    List.append
        [ ( \gd ggd ->
                renderSprite gd [] (getPositionUnderCamera ( 32 * 86, 54 * 32 ) ggd) ( 32 * 14, 0 ) "lx/mountain"
          , FrontSolids
          )
        ]
        (makemanybamboos ( 272, 2130 ) 3)
        ++ makemanybamboos ( 872, 2130 ) 3
        ++ makemanybamboos ( 3100, 2130 ) 30
