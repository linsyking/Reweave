module Scenes.Level1.Config exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Components.Hints.Export as Hints
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Scenes.Level1.Map exposing (mymap)


initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "20", "300", "100", "50", "Beimin   北溟" ])
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
        , initGameComponent t (GameExitInit (ExitInit ( 200, 1710 ) "Level0" (CustomPlayerPosition ( 3446, 1800 )) 2)) Exit.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 864, 2016 ) HorDown 15 12)) Spike.gameComponent
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
    []
