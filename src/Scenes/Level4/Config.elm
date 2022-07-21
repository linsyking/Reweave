module Scenes.Level4.Config exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Color
import Components.Hints.Export as Hints
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Monster.Base exposing (MonsterInit)
import Lib.CoreEngine.GameComponents.Monster.Export as Monster
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite, renderText, renderTextWithColor)
import Lib.Scene.Base exposing (PlayerInitPosition(..))
import Scenes.Level4.Map exposing (mymap)


initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "Use W,A,D to move and jump", "Use Esc to call the menu" ])
        ]


initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            --initGameComponent t (GamePlayerInit (PlayerInit ( 50, 2000 ))) Player.gameComponent
            initGameComponent t (GamePlayerInit (PlayerInit ( 3744, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameGoombaInit (GoombaInit ( 3360, 1696 ) ( 0, 0 ) 2)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 4416, 1696 ) ( 0, 0 ) 3)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 4416, 1800 ) ( 0, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 5300, 1800 ) ( 0, 0 ) 5)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 832, 1600 ) ( 0, 0 ) 6)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1280, 1696 ) ( 0, 0 ) 7)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1760, 1800 ) ( 0, 0 ) 8)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 2240, 1800 ) ( 0, 0 ) 9)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 3840, 2080 ) ( 0, 0 ) 15)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 4160, 2080 ) ( 0, 0 ) 16)) Goomba.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 6350, 1920 ) ( 10, 160 ) "Scene1" 9)) Exit.gameComponent
        --, initGameComponent t (GameCutSceneInit (CutSceneInit ( 100, 1800 ) ( 100, 160 ) 88 [ ( "1", "Dear master, I want learn something from you", True ), ( "1", "Yes, please go ahead.", False ) ])) CutScene.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 640, 2060 ) HorUp 3 12)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 1568, 2060 ) HorUp 3 13)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 3360, 1408 ) HorDown 9 10)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 3232, 2160 ) HorUp 15 11)) Spike.gameComponent
        , initGameComponent t (GameMonsterInit (MonsterInit ( 5632, 100 ) ( 0, 0 ) "fish" "default" 100)) Monster.gameComponent
        ]


initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 199 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


initGameGlobalData : Float -> GameGlobalData
initGameGlobalData e =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 200, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level4"
    }


allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    []
