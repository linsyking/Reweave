module Scenes.Level0.Config exposing (..)

{-| This is the doc for this module

@docs initFrontGroundComponents

@docs initPlayer

@docs initActors

@docs initCamera

@docs dialogues

@docs initGameGlobalData

@docs allChartlets

@docs makemanybamboos

-}

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
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
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Scenes.Level0.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Int -> Array Component
initFrontGroundComponents t sp =
    case sp of
        0 ->
            Array.fromList
                [ Hints.initComponent t (ComponentLStringMsg [ "50", "750", "700", "30", "Use A,D to move to left and right, Use C or Space to jump", "Use Esc to call the menu" ])
                ]

        _ ->
            Array.empty


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 200, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Int -> Array GameComponent
initActors t sp =
    case sp of
        0 ->
            Array.fromList
                [ initGameComponent t (GameExitInit (ExitInit ( 3700, 1910 ) "Level1" DefaultPlayerPosition 0 2)) Exit.gameComponent
                , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2220 ) HorUp 100 False 3)) Spike.gameComponent
                , initGameComponent t (GameCutSceneInit (CutSceneInit ( 2440, 1820 ) ( 100, 100 ) 88 dialogues True)) CutScene.gameComponent
                ]

        1 ->
            Array.fromList
                [ initGameComponent t (GameExitInit (ExitInit ( 3700, 1910 ) "Level1" DefaultPlayerPosition 0 2)) Exit.gameComponent
                , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2220 ) HorUp 100 False 3)) Spike.gameComponent
                ]

        _ ->
            Array.empty


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


{-| dialogues
-}
dialogues : List ( String, String )
dialogues =
    [ ( "p_profile", "Hello, master." )
    , ( "master", "Hi" )
    ]


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col spstate =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level0"
    , collectedMonsters = col
    , settingpause = False
    , specialState = spstate
    }


{-| allChartlets
-}
allChartlets : Int -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets sp =
    makemanybamboos 9
        ++ [ ( \gd ggd ->
                renderSprite gd [] (getPositionUnderCamera ( 1980, 1525 ) ggd) ( 1000, 0 ) "zy/building"
             , BehindActors
             )
           , case sp of
                0 ->
                    ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( 2440, 1820 ) ggd) ( 100, 0 ) "master"
                    , BehindActors
                    )

                _ ->
                    ( \_ _ -> group [] [], BehindActors )
           ]


{-| makemanybamboos
-}
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