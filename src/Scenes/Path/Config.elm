module Scenes.Path.Config exposing
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
import Lib.Resources.Monster exposing (isInCollected)
import Scenes.Path.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> List String -> Array Component
initFrontGroundComponents t cs =
    Array.fromList
        ((if judgefinish cs then
            []

          else
            [ Hints.initComponent t (ComponentLStringMsg [ "100", "980", "700", "40", "Seems that you haven't collected all the monsters", "The teleporter will not start if you don't collect all of them" ]) ]
         )
            ++ [ Hints.initComponent t (ComponentLStringMsg [ "40", "1380", "30", "50", "JiangNan Path  江南小道" ]) ]
        )


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 350, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


judgefinish : List String -> Bool
judgefinish ls =
    isInCollected "fish" ls
        && isInCollected "bird" ls
        && isInCollected "turtle" ls
        && isInCollected "lion" ls
        && isInCollected "fox" ls


{-| initActors
-}
initActors : Int -> List String -> Array GameComponent
initActors t cs =
    Array.fromList
        ((if judgefinish cs then
            [ initGameComponent t (GameExitInit (ExitInit ( 1700, 2000 ) "End" DefaultPlayerPosition 0 9)) Exit.gameComponent ]

          else
            []
         )
            ++ [ initGameComponent t (GameExitInit (ExitInit ( 60, 2000 ) "Level5boss" (CustomPlayerPosition ( 989, 1320 )) 0 9)) Exit.gameComponent ]
        )


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 61 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col t =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 62, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Path"
    , collectedMonsters = col
    , settingpause = False
    , specialState = 0
    , ingameTime = t
    }


{-| allChartlets
-}
allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    [ ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 1200, 1960 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 1400, 1960 ) ggd) ( 32 * 5, 0 ) "jn/willow"
      , BehindActors
      )
    ]
