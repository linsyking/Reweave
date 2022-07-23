module Scenes.Level0.Config exposing
    ( initFrontGroundComponents
    , initPlayer
    , initActors
    , initCamera
    , dialogues
    , initGameGlobalData
    , allChartlets
    )

{-| This is the doc for this module

@docs initFrontGroundComponents

@docs initPlayer

@docs initActors

@docs initCamera

@docs dialogues

@docs initGameGlobalData

@docs allChartlets

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
import Lib.Map.Longxi exposing (makemanybamboos)
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
                , Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "Beiming  北溟" ])
                , Hints.initComponent t (ComponentLStringMsg [ "40", "1570", "100", "35", "Near A Temple 寺庙旁" ])
                ]

        _ ->
            Array.fromList
                [ Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "Beiming  北溟" ])
                , Hints.initComponent t (ComponentLStringMsg [ "40", "1570", "100", "35", "Near A Temple  寺庙旁" ])
                ]


{-| initPlayer
-}
initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 1981, 1800 ))) Player.gameComponent
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
                [ initGameComponent t (GameExitInit (ExitInit ( 3650, 1750 ) "Level1" DefaultPlayerPosition 0 2)) Exit.gameComponent
                , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2220 ) HorUp 100 False 3)) Spike.gameComponent
                , initGameComponent t (GameCutSceneInit (CutSceneInit ( 2440, 1820 ) ( 100, 100 ) 88 dialogues True)) CutScene.gameComponent
                ]

        1 ->
            Array.fromList
                [ initGameComponent t (GameExitInit (ExitInit ( 3650, 1750 ) "Level1" DefaultPlayerPosition 0 2)) Exit.gameComponent
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
    , ( "master", "Hi, I heard that you wanted to reweave all the monsters." )
    , ( "p_profile", "Yes, they were so crazy after they escaped from the sroll." )
    , ( "master", "I will teach you some techniques to move and fight better." )
    , ( "p_profile", "Thank you." )
    , ( "master", "Did you see a white point shining on your body?" )
    , ( "p_profile", "Yes, what is that?" )
    , ( "master", "It is a sign that you selected yourself." )
    , ( "p_profile", "...Selected?" )
    , ( "master", "You can change the selected objects by click on them." )
    , ( "master", "Almost all the movable objects can be selected." )
    , ( "p_profile", "And how can I use those selected objects?" )
    , ( "master", "When an object has much energy, the point will become blue." )
    , ( "master", "And then, you can press key W to grasp them." )
    , ( "master", "And if you want to release energy on the selected objects," )
    , ( "master", "Right click at where you want it to go on the screen!" )
    , ( "master", "The larger the distance between your mouse and the object," )
    , ( "master", "The larger energy you will use on the object." )
    , ( "master", "You also have an energy ball at the left top corner." )
    , ( "p_profile", "When I use energy, it will decrease, I guess!" )
    , ( "master", "Yes, but when you are in the air," )
    , ( "master", "You cannot use energy on yourself." )
    , ( "master", "However you can still use energy on other objects." )
    , ( "p_profile", "Alright." )
    , ( "master", "There are many danger in your journey," )
    , ( "master", "Please be cautious." )
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
    makemanybamboos ( 70, 2093 ) 9
        ++ [ ( \gd ggd ->
                renderSprite gd [] (getPositionUnderCamera ( 2140, 1520 ) ggd) ( 700, 0 ) "zy/building"
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
