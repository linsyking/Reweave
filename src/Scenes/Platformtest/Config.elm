module Scenes.Platformtest.Config exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Scene.Base exposing (PlayerInitPosition(..))
import Scenes.Platformtest.Map exposing (mymap)


initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents _ =
    Array.fromList
        []


initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 3550, 1800 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


initActors : Int -> Array GameComponent
initActors _ =
    Array.empty


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
    , currentScene = "Platformtest"
    }


allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    []
