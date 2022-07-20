module Scenes.Level1.Config exposing (..)

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
import Lib.CoreEngine.GameComponents.Bullet.Base exposing (BulletInit)
import Lib.CoreEngine.GameComponents.Bullet.Export as Bullet
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Export as GoombaEmitter
import Lib.CoreEngine.GameComponents.Monster.Base exposing (MonsterInit)
import Lib.CoreEngine.GameComponents.Monster.Export as Monster
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite, renderText)
import Lib.Scene.Base exposing (PlayerInitPosition(..))
import Scenes.Level1.Map exposing (mymap)


initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "Use W,A,D to move and jump", "Use Esc to call the menu" ])
        ]


initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 50, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameGoombaInit (GoombaInit ( 1200, 1800 ) ( 0, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1000, 1800 ) ( 0, 0 ) 5)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 2000, 800 ) ( 0, 0 ) 2)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 3500, 500 ) ( 0, 0 ) 3)) Goomba.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 3800, 1600 ) ( 10, 160 ) "Scene1" 9)) Exit.gameComponent
        , initGameComponent t (GameCutSceneInit (CutSceneInit ( 100, 1800 ) ( 100, 160 ) 88 [ ( "1", "yes jnot jeudnst", True ), ( "1", "no i feel bad", True ) ])) CutScene.gameComponent
        , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 900, 1800 ) 200 ( -50, 0 ) 6)) GoombaEmitter.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 704, 2028 ) HorUp 1 10)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 736, 2048 ) VerRight 3 11)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 864, 2016 ) HorDown 15 12)) Spike.gameComponent
        , initGameComponent t (GameBulletInit (BulletInit ( 1800, 1930 ) ( -50, 0 ) 13)) Bullet.gameComponent
        , initGameComponent t (GameMonsterInit (MonsterInit ( 1200, 30 ) ( 0, 0 ) 100)) Monster.gameComponent
        ]


initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


initGameGlobalData : Float -> GameGlobalData
initGameGlobalData e =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level1"
    }


allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd -> renderText gd 50 "Hit those goombas!" "Times New Roman" (getPositionUnderCamera ( 900, 2100 ) ggd), BehindActors )
    , ( \gd ggd -> renderSprite gd [] (getPositionUnderCamera ( 0, 2176 ) ggd) ( 3840, 64 ) "background", FrontSolids )
    , ( \gd ggd -> renderText gd 40 "Short Description (Will be deleted in the real game, this is only for the game testers)" "Times New Roman" (getPositionUnderCamera ( 200, 1400 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "1. Use Mouse to left click on any object to select it" "Times New Roman" (getPositionUnderCamera ( 200, 1450 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "2. Press 'C' key to grasp its kinetic energy(if its energy is too low, you cannot grasp it)" "Times New Roman" (getPositionUnderCamera ( 200, 1500 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "3. Select any new object(Of course you can choose not to change)" "Times New Roman" (getPositionUnderCamera ( 200, 1550 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "4. Right click on any position to use the kinetic energy on the chosen object" "Times New Roman" (getPositionUnderCamera ( 200, 1600 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 100 "Test Chamber" "Times New Roman" (getPositionUnderCamera ( 200, 1250 ) ggd), BehindActors )
    ]
