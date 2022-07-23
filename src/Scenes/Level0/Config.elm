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
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Export as Energy
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition(..))
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.SavePoint.Base exposing (SavePointInit)
import Lib.CoreEngine.GameComponents.SavePoint.Export as Save
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Map.Longxi exposing (makemanybamboos)
import Lib.Render.Render exposing (renderSprite, renderText)
import Scenes.Level0.Map exposing (mapwidth, mymap)


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
            initGameComponent t (GamePlayerInit (PlayerInit ( 5400, 680 ))) Player.gameComponent

        -- initGameComponent t (GamePlayerInit (PlayerInit ( 200, 2000 ))) Player.gameComponent
        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Int -> Array GameComponent
initActors t sp =
    Array.append
        (Array.fromList
            [ initGameComponent t (GameExitInit (ExitInit ( 6170, 630 ) "Level1" DefaultPlayerPosition 0 2)) Exit.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2220 ) HorUp 200 False 3)) Spike.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 2903, 1800 ) 4)) Save.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3153, 1850 ) 300 True 5)) Energy.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3463, 1850 ) 500 False 6)) Energy.gameComponent
            , initGameComponent t (GameGoombaInit (GoombaInit ( 3863, 1850 ) ( -50, 0 ) 7)) Goomba.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 4121, 1576 ) 8)) Save.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 4270, 2086 ) HorUp 13 True 9)) Spike.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 4900, 2016 ) 2000 True 10)) Energy.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 4772, 1992 ) 11)) Save.gameComponent
            ]
        )
        (case sp of
            0 ->
                Array.fromList
                    [ initGameComponent t (GameCutSceneInit (CutSceneInit ( 2440, 1820 ) ( 100, 100 ) 88 dialogues True)) CutScene.gameComponent
                    ]

            2 ->
                Array.fromList
                    [ initGameComponent t (GameCutSceneInit (CutSceneInit ( 2440, 1820 ) ( 100, 100 ) 88 dialogues True)) CutScene.gameComponent
                    ]

            _ ->
                Array.empty
        )


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * (mapwidth - 1) - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


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
    , ( "master", "Yes, it shows your energy." )
    , ( "master", "Another important rule is that, in the air," )
    , ( "master", "You cannot use energy on yourself," )
    , ( "master", "But you can still use energy on other objects." )
    , ( "p_profile", "Alright." )
    , ( "master", "There are many dangers in your journey," )
    , ( "master", "Please be cautious." )
    , ( "master", "I have prepared several easy tasks for you," )
    , ( "master", "You can have a warmup." )
    ]


{-| initGameGlobalData
-}
initGameGlobalData : Float -> List String -> Int -> GameGlobalData
initGameGlobalData e col spstate =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( mapwidth, 70 )
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
           , ( \gd ggd -> renderText gd 30 "SavePoint" "Times New Roman" (getPositionUnderCamera ( 2880, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Energy Crystal " "Times New Roman" (getPositionUnderCamera ( 3080, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "(Recoverable)" "Times New Roman" (getPositionUnderCamera ( 3080, 1760 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Energy Crystal" "Times New Roman" (getPositionUnderCamera ( 3390, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "(Irrecoverable)" "Times New Roman" (getPositionUnderCamera ( 3390, 1760 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Hit the goomba to get on the platform!" "Times New Roman" (getPositionUnderCamera ( 3690, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Jump at the last monent" "Times New Roman" (getPositionUnderCamera ( 4200, 1360 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Press W to save the energy from the player the moment before you hit the ground!" "Times New Roman" (getPositionUnderCamera ( 4200, 1430 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Ritgh Click on the top of your screen" "Times New Roman" (getPositionUnderCamera ( 4690, 1760 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "And don't forget to move right!" "Times New Roman" (getPositionUnderCamera ( 4690, 1830 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 40 "You are ready to go!" "Times New Roman" (getPositionUnderCamera ( 5390, 500 ) ggd), BehindActors )
           ]
