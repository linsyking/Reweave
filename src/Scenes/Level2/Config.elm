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
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)
import Lib.CoreEngine.GameComponents.Bone.Export as Bone
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Export as GoombaEmitter
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Scenes.Level2.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents _ =
    Array.fromList
        []


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 2358, 2056 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameGoombaInit (GoombaInit ( 800, 2100 ) ( 0, 0 ) 3)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1500, 1750 ) ( 50, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1550, 1750 ) ( -50, 0 ) 5)) Goomba.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 3800, 1600 ) "Scene1" DefaultPlayerPosition 0 6)) Exit.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 590, 2190 ) HorUp 3 True 7)) Spike.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 1330, 2150 ) 150 8)) Bone.gameComponent
        , initGameComponent t (GameBoneInit (BoneInit ( 1460, 2150 ) 150 9)) Bone.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 46 * 32, 50 * 32 + 20 ) HorDown 2 True 10)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 46 * 32, 50 * 32 - 20 ) HorUp 2 True 11)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 32 * 50, 2190 ) HorUp 25 True 12)) Spike.gameComponent
        , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 32 * 92, 53 * 32 ) 360 ( -50, 0 ) 13)) GoombaEmitter.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 32 * 80, 2195 ) HorUp 2 True 14)) Spike.gameComponent
        ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


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
    , currentScene = "Level2"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 32 * 86, 54 * 32 ) ggd) ( 32 * 14, 0 ) "lx/mountain"
      , FrontSolids
      )
    ]
