module Scenes.Level1.Config exposing
    ( initFrontGroundComponents
    , initPlayer
    , initActors
    , initCamera
    , initGameGlobalData
    , allChartlets
    , makemanywaves
    )

{-| This is the doc for this module

@docs initFrontGroundComponents

@docs initPlayer

@docs initActors

@docs initCamera

@docs initGameGlobalData

@docs allChartlets

@docs makemanywaves

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
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.CutScene.Export as CutScene
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Monster.Base exposing (MonsterInit)
import Lib.CoreEngine.GameComponents.Monster.Export as Monster
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)
import Lib.CoreEngine.GameComponents.SavePoint.Export as Save
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Render.Render exposing (renderSprite)
import Lib.Resources.Monster exposing (isInCollected)
import Scenes.Level1.Map exposing (mymap)


{-| initFrontGroundComponents
-}
initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents t =
    Array.fromList
        [ Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "BeiMing  北溟" ])
        , Hints.initComponent t (ComponentLStringMsg [ "40", "1590", "100", "35", "Near A River 小河边" ])
        ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 3197, 1480 ))) Player.gameComponent
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 3168, 1000 ))) Player.gameComponent
            initGameComponent t (GamePlayerInit (PlayerInit ( 342, 1160 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> List String -> Array GameComponent
initActors t cs =
    Array.fromList
        ([ initGameComponent t (GameExitInit (ExitInit ( 10, 1100 ) "Level0" (CustomPlayerPosition ( 9110, 680 )) 1 6)) Exit.gameComponent
         , initGameComponent t (GameCutSceneInit (CutSceneInit ( 475, 1680 ) ( 100, 100 ) 5 dialoguesMaster True)) CutScene.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2200 ) HorUp 1000 False 3)) Spike.gameComponent
         , initGameComponent t (GameSpikeInit (SpikeInit ( 1440, 1900 ) HorUp 1 True 4)) Spike.gameComponent
         , initGameComponent t (GameExitInit (ExitInit ( 3600, 1300 ) "Level2" DefaultPlayerPosition 0 7)) Exit.gameComponent

         -- , initGameComponent t (GameGoombaInit (GoombaInit ( 3425, 1928 ) ( 50, 0 ) 8)) Goomba.gameComponent
         , initGameComponent t (GameCutSceneInit (CutSceneInit ( 3140, 1440 ) ( 100, 100 ) 10 dialoguesBird False)) CutScene.gameComponent
         , initGameComponent t (GameSavePointInit (SavePointInit ( 3280, 1416 ) 11)) Save.gameComponent
         ]
            ++ (if isInCollected "bird" cs then
                    []

                else
                    [ initGameComponent t (GameMonsterInit (MonsterInit ( 3140, 1430 ) ( 174, 138 ) False "bird" 10 9)) Monster.gameComponent ]
               )
        )


dialoguesMaster : List ( String, String )
dialoguesMaster =
    [ ( "p_profile", "Hello, master." )
    , ( "master", "I still worry about you." )
    , ( "master", "There is a monster ahead of you." )
    , ( "master", "You have to hit it with your body to reweave it." )
    , ( "p_profile", "OK." )
    ]


dialoguesBird : List ( String, String )
dialoguesBird =
    [ ( "p_profile", "Wow, who are you?" )
    , ( "bird", "Hi, I am LuanNiao." )
    , ( "p_profile", "Beautiful Bird." )
    , ( "bird", "I am willing to help you in your journey, don't be afraid." )
    , ( "p_profile", "Thank you." )
    , ( "", "(You can go to menu to check the monsters you have collected)" )
    ]


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 700 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.2 ), ( 0.4, 0.1 ) )


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col t =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "Level1"
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
            renderSprite gd [] (getPositionUnderCamera ( 32, 1250 ) ggd) ( 32 * 14, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 32, 1450 ) ggd) ( 32 * 14, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 32, 1650 ) ggd) ( 32 * 14, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 32, 1850 ) ggd) ( 32 * 14, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 475, 1680 ) ggd) ( 100, 0 ) "master"
      , BehindActors
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 3497, 1470 ) ggd) ( 32 * 10, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 3497, 1770 ) ggd) ( 32 * 10, 0 ) "dh/bigrock"
      , FrontSolids
      )
    , ( \gd ggd ->
            renderSprite gd [] (getPositionUnderCamera ( 3497, 2070 ) ggd) ( 32 * 10, 0 ) "dh/bigrock"
      , FrontSolids
      )
    ]
        ++ makemanywaves 4


{-| makemanywaves
-}
makemanywaves : Int -> List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
makemanywaves n =
    List.foldl
        (\i al ->
            al
                ++ [ ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( 450 + 770 * i, 2135 ) ggd) ( 800, 0 ) "bm/smallwave"
                     , FrontSolids
                     )
                   ]
        )
        []
        (List.range 0 (n - 1))
