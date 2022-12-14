module Scenes.TestChamber.Config exposing
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

-- import Lib.CoreEngine.GameComponents.Fish.Base exposing (FishInit)
-- import Lib.CoreEngine.GameComponents.Fish.Export as Fish
-- import Lib.CoreEngine.GameComponents.Turtle.Base exposing (TurtleInit)
-- import Lib.CoreEngine.GameComponents.Turtle.Export as Turtle
-- import Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)
-- import Lib.CoreEngine.GameComponents.Bone.Export as Bone

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Ball.Base exposing (BallInit)
import Lib.CoreEngine.GameComponents.Ball.Export as Ball
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as EnergyCrystal
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Export as GoombaEmitter
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)
import Lib.CoreEngine.GameComponents.SavePoint.Export as SavePoint
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.TestChamber.Map exposing (mymap)


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
            initGameComponent t (GamePlayerInit (PlayerInit ( 2000, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameGoombaInit (GoombaInit ( 1200, 1800 ) ( 0, 0 ) 50 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1000, 1800 ) ( 0, 0 ) 50 5)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 2000, 800 ) ( 0, 0 ) 50 2)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 3500, 500 ) ( 0, 0 ) 50 3)) Goomba.gameComponent
        , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 2200, 2000 ) 300 True 17)) EnergyCrystal.gameComponent

        -- , initGameComponent t (GameExitInit (ExitInit ( 3600, 1750 ) "Level4" 9)) Exit.gameComponent
        -- , initGameComponent t (GameCutSceneInit (CutSceneInit ( 2900, 1800 ) ( 100, 160 ) 88 [ ( "p_profile", "Dear master, I want learn something from you" ), ( "master", "Yes, please go ahead." ) ] True)) CutScene.gameComponent
        , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 900, 1800 ) 200 ( -50, 0 ) 6)) GoombaEmitter.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 704, 2028 ) HorUp 1 True 10)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 736, 2048 ) VerRight 3 True 11)) Spike.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 864, 2016 ) HorDown 15 True 12)) Spike.gameComponent

        -- , initGameComponent t (GameBoneInit (BoneInit ( 2400, 2000 ) 200 13)) Bone.gameComponent
        , initGameComponent t (GameBallInit (BallInit ( 2700, 1800 ) 100 14)) Ball.gameComponent
        , initGameComponent t (GameSavePointInit (SavePointInit ( 2300, 2000 ) 15)) SavePoint.gameComponent

        -- , initGameComponent t (GameFishInit (FishInit ( 100, 1000 ) 88 229)) Fish.gameComponent
        -- , initGameComponent t (GameTurtleInit (TurtleInit ( 2700, 1000 ) 88 100)) Turtle.gameComponent
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
    , currentScene = "Test"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd -> renderText gd 50 "Hit those goombas!" "Times New Roman" (getPositionUnderCamera ( 900, 2100 ) ggd), BehindActors )
    , ( \gd ggd -> renderSprite gd [] (getPositionUnderCamera ( 0, 2176 ) ggd) ( 3840, 64 ) "background", FrontSolids )
    , ( \gd ggd -> renderText gd 40 "Short Description (Will be deleted in the real game, this is only for the game testers)" "Times New Roman" (getPositionUnderCamera ( 200, 1400 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "1. Use Mouse to left click on any object to select it" "Times New Roman" (getPositionUnderCamera ( 200, 1450 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "2. Press 'W' key to grasp its kinetic energy(if its energy is too low, you cannot grasp it)" "Times New Roman" (getPositionUnderCamera ( 200, 1500 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "3. Select any new object(Of course you can choose not to change)" "Times New Roman" (getPositionUnderCamera ( 200, 1550 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "4. Right click on any position to use the kinetic energy on the chosen object" "Times New Roman" (getPositionUnderCamera ( 200, 1600 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 100 "Test Chamber" "Times New Roman" (getPositionUnderCamera ( 200, 1250 ) ggd), BehindActors )
    ]
