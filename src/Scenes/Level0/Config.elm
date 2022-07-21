module Scenes.Level0.Config exposing (..)

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
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Lib.Scene.Base exposing (PlayerInitPosition(..))
import Scenes.Level0.Map exposing (mymap)


initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "Use A,D to move to left and right, Use C or Space to jump", "Use Esc to call the menu" ])
        ]


initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 200, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameExitInit (ExitInit ( 3700, 1910 ) "Test" 2)) Exit.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2220 ) HorUp 100 3)) Spike.gameComponent
        , initGameComponent t (GameCutSceneInit (CutSceneInit ( 2440, 1820 ) ( 100, 100 ) 88 dialogues True)) CutScene.gameComponent
        ]


initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


dialogues : List ( String, String )
dialogues =
    [ ( "p_profile", "Hello, master." )
    , ( "master", "Hi" )
    ]


initGameGlobalData : Float -> GameGlobalData
initGameGlobalData e =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level0"
    }


allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 1980, 1525 ) ggd) ( 1000, 0 ) "zy/building"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2440, 1820 ) ggd) ( 100, 0 ) "master"
      , BehindActors
      )
    ]
        ++ makemanybamboos 9


makemanybamboos : Int -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
makemanybamboos n =
    List.foldl
        (\i al ->
            al
                ++ [ ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( 70 + i * 100, 2093 ) ggd) ( 100, 0 ) "bamboo"
                     , BehindActors
                     )
                   ]
        )
        []
        (List.range 0 (n - 1))
