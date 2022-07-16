module Scenes.Level1.Config exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Level1.Map exposing (mymap)


initPlayer : GameComponent
initPlayer =
    initGameComponent 0 (GamePlayerInit (PlayerInit ( 50, 2000 ))) Player.gameComponent


initActors : Array GameComponent
initActors =
    Array.fromList
        [ initGameComponent 0 (GameGoombaInit (GoombaInit ( 1200, 1800 ) ( 0, 0 ) 4)) Goomba.gameComponent
        , initGameComponent 0 (GameExitInit (ExitInit ( 3800, 1600 ) ( 10, 160 ) "Scene1" 9999)) Exit.gameComponent
        , initGameComponent 0 (GameGoombaInit (GoombaInit ( 1000, 1800 ) ( 0, 0 ) 5)) Goomba.gameComponent
        ]


initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 70 * 32 - 1 ) )


initGameGlobalData : Float -> GameGlobalData
initGameGlobalData e =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = -1
    , energy = e
    , ingamepause = False
    , currentScene = "Level1"
    }


allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd -> renderText gd 50 "Hit those goombas!" "Times New Roman" (getPositionUnderCamera ( 900, 2100 ) ggd), BehindActors )
    , ( \gd ggd -> renderSprite gd [] (getPositionUnderCamera ( 0, 2176 ) ggd) ( 3840, 64 ) "background" gd.sprites, FrontSolids )
    ]
