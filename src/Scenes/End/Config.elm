module Scenes.End.Config exposing
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
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Scenes.End.Map exposing (mapwidth, mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "40", "600", "500", "90", "Thanks for playing" ])
        , Hints.initComponent t (ComponentLStringMsg [ "200", "1600", "100", "60", "Director" ])
        , Hints.initComponent t (ComponentLStringMsg [ "200", "1600", "170", "40", "Xiang Yiming" ])
        , Hints.initComponent t (ComponentLStringMsg [ "500", "1400", "600", "60", "Art & Music Design" ])
        , Hints.initComponent t (ComponentLStringMsg [ "500", "1400", "670", "40", "Wang Dayong" ])
        , Hints.initComponent t (ComponentLStringMsg [ "800", "300", "600", "60", "Level Design" ])
        , Hints.initComponent t (ComponentLStringMsg [ "800", "300", "670", "40", "Xiang Yiming, Zhang Jingjing" ])
        , Hints.initComponent t (ComponentLStringMsg [ "1100", "300", "100", "60", "Game Engine" ])
        , Hints.initComponent t (ComponentLStringMsg [ "1100", "300", "170", "40", "Xiang Yiming, Duan Lingbo" ])
        , Hints.initComponent t (ComponentLStringMsg [ "1500", "600", "400", "90", "Technical Support" ])
        , Hints.initComponent t (ComponentLStringMsg [ "1500", "750", "550", "60", "SFOCS Staffs" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 250, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameExitInit (ExitInit ( 10, 2000 ) "Path" (CustomPlayerPosition ( 1344, 2056 )) 0 2)) Exit.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 9300, 2000 ) "Home" DefaultPlayerPosition 0 3)) Exit.gameComponent
        ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * (mapwidth - 1) - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> GameGlobalData
initGameGlobalData e col =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( mapwidth, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "End"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 3800, 1820 ) ggd) ( 32 * 14, 0 ) "bird"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 800, 1820 ) ggd) ( 32 * 14, 0 ) "turtle"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 1600, 1820 ) ggd) ( 32 * 14, 0 ) "fish"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 2400, 1840 ) ggd) ( 32 * 10, 0 ) "fox"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 3000, 1820 ) ggd) ( 32 * 14, 0 ) "lion"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 4400, 1970 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 5000, 1970 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 5600, 1970 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 6200, 1970 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindActors
      )
    ]
