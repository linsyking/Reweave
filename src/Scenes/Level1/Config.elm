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
import Lib.Scene.Base exposing (PlayerInitPosition(..))
import Scenes.Level1.Map exposing (mymap)


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
        , initGameComponent t (GameExitInit (ExitInit ( 3800, 1600 ) ( 10, 160 ) "Scene1" 9999)) Exit.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1000, 1800 ) ( 0, 0 ) 5)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 2000, 800 ) ( 0, 0 ) 2)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 3500, 500 ) ( 0, 0 ) 3)) Goomba.gameComponent
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
    , ( \gd ggd -> renderText gd 40 "Short Description (Will be deleted in the real game, this is only for the game testers)" "Times New Roman" (getPositionUnderCamera ( 200, 1400 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "1. Use Mouse to left click on any object to select it" "Times New Roman" (getPositionUnderCamera ( 200, 1450 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "2. Press 'C' key to grasp its kinetic energy(if its energy is too low, you cannot grasp it)" "Times New Roman" (getPositionUnderCamera ( 200, 1500 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "3. Select any new object(Of course you can choose not to change)" "Times New Roman" (getPositionUnderCamera ( 200, 1550 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 30 "4. Right click on any position to use the kinetic energy on the chosen object" "Times New Roman" (getPositionUnderCamera ( 200, 1600 ) ggd), BehindActors )
    , ( \gd ggd -> renderText gd 100 "Test Chamber" "Times New Roman" (getPositionUnderCamera ( 200, 1250 ) ggd), BehindActors )
    ]
