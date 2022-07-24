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
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Export as GoombaEmitter
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
initFrontGroundComponents t _ =
    -- case sp of
    --     0 ->
    --         Array.fromList
    --             [ Hints.initComponent t (ComponentLStringMsg [ "50", "750", "700", "30", "Use A,D to move to left and right, Use C or Space to jump", "Use Esc to call the menu" ])
    --             , Hints.initComponent t (ComponentLStringMsg [ "40", "1600", "30", "50", "Beiming  北溟" ])
    --             , Hints.initComponent t (ComponentLStringMsg [ "40", "1570", "100", "35", "Near A Temple 寺庙旁" ])
    --             ]
    --     _ ->
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
            -- initGameComponent t (GamePlayerInit (PlayerInit ( 7054, 680 ))) Player.gameComponent
            initGameComponent t (GamePlayerInit (PlayerInit ( 200, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


{-| initActors
-}
initActors : Int -> Int -> Array GameComponent
initActors t sp =
    Array.append
        (Array.fromList
            [ initGameComponent t (GameExitInit (ExitInit ( 9380, 630 ) "Level1" DefaultPlayerPosition 0 2)) Exit.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 0, 2220 ) HorUp 200 False 3)) Spike.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 2903, 1800 ) 4)) Save.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3153, 1850 ) 300 True 5)) Energy.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 3463, 1850 ) 500 False 6)) Energy.gameComponent

            -- , initGameComponent t (GameGoombaInit (GoombaInit ( 3863, 1850 ) ( -50, 0 ) 50 7)) Goomba.gameComponent
            , initGameComponent t (GameGoombaEmitterInit (GoombaEmitterInit ( 3560, 1890 ) 100 ( 50, 0 ) 7)) GoombaEmitter.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 3970, 1894 ) VerLeft 1 True 30)) Spike.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 4121, 1576 ) 8)) Save.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 4270, 2086 ) HorUp 13 True 9)) Spike.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 4900, 2016 ) 2000 True 10)) Energy.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 4772, 1992 ) 11)) Save.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 5400, 680 ) 12)) Save.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 5925, 530 ) HorDown 11 True 13)) Spike.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 5925, 500 ) HorUp 11 True 14)) Spike.gameComponent
            , initGameComponent t (GameGoombaInit (GoombaInit ( 6200, 680 ) ( -50, 0 ) 30 15)) Goomba.gameComponent
            , initGameComponent t (GameGoombaInit (GoombaInit ( 5950, 680 ) ( 50, 0 ) 30 31)) Goomba.gameComponent
            , initGameComponent t (GameGoombaInit (GoombaInit ( 6100, 680 ) ( 50, 0 ) 30 32)) Goomba.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 5600, 730 ) 700 False 16)) Energy.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 7227, 1832 ) 17)) Save.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 7500, 1870 ) 1000 True 18)) Energy.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 7600, 1870 ) 1000 True 19)) Energy.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 7700, 1870 ) 1000 True 20)) Energy.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 7950, 1870 ) 2000 True 21)) Energy.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 8350, 1870 ) 2000 True 22)) Energy.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 7767, 1410 ) HorUp 1 True 23)) Spike.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 7767, 1140 ) HorDown 1 True 24)) Spike.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 7767 + 12 * 32, 1410 - 5 * 32 ) HorUp 1 True 25)) Spike.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 7767 + 12 * 32, 1140 - 5 * 32 ) HorDown 1 True 26)) Spike.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 7767 + 24 * 32, 1410 - 20 * 32 ) HorUp 1 True 27)) Spike.gameComponent
            , initGameComponent t (GameSpikeInit (SpikeInit ( 7767 + 24 * 32, 1140 - 20 * 32 ) HorDown 1 True 28)) Spike.gameComponent
            , initGameComponent t (GameSavePointInit (SavePointInit ( 8257, 1832 ) 29)) Save.gameComponent
            , initGameComponent t (GameEnergyCrystalInit (EnergyCrystalInit ( 7000, 700 ) 400 True 35)) Energy.gameComponent
            ]
        )
        (case sp of
            0 ->
                Array.fromList
                    [ initGameComponent t (GameCutSceneInit (CutSceneInit ( 2440, 1820 ) ( 100, 100 ) 88 dialogues True)) CutScene.gameComponent
                    , initGameComponent t (GameCutSceneInit (CutSceneInit ( 4250, 1820 ) ( 60, 100 ) 89 dialogues2 True)) CutScene.gameComponent
                    ]

            _ ->
                Array.empty
        )


{-| initCamera
-}
initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * (mapwidth - 1) - 1, 69 * 32 - 1 ) ) ( ( 0.2, 0.8 ), ( 0.4, 0.2 ) )


{-| dialogues
-}
dialogues : List ( String, String )
dialogues =
    [ ( "", "(Left click to continue the dialogue)" )
    , ( "p_profile", "Hello, master." )
    , ( "master", "Hi, I heard that you wanted to reweave all the monsters." )
    , ( "p_profile", "Yes, they were so crazy after they escaped from the sroll." )
    , ( "master", "I will teach you some techniques to move and fight better." )
    , ( "p_profile", "Thank you." )
    , ( "master", "Can you see an energy ball at the left top corner?" )
    , ( "p_profile", "Yes, what is that?" )
    , ( "master", "It shows your energy." )
    , ( "master", "If you have much energy, you can use it to help you reweave!" )
    , ( "master", "First, try to eat some energy crystal ahead of you." )
    , ( "master", "See what will happen on your energy ball." )
    , ( "", "(You can also right click to skip the dialogue)" )
    ]


dialogues2 : List ( String, String )
dialogues2 =
    [ ( "master", "Did you see a white point shining on your body?" )
    , ( "p_profile", "Yes, what is that?" )
    , ( "master", "It is a sign that you selected yourself." )
    , ( "p_profile", "...Selected?" )
    , ( "master", "You can change the selected objects by click on them." )
    , ( "master", "Almost all the movable objects can be selected." )
    , ( "p_profile", "And how can I use those selected objects?" )
    , ( "master", "When an object has much energy, the point will become blue." )
    , ( "master", "And then, you can press key W to grasp their energy." )
    , ( "master", "If you want to release energy on the selected objects," )
    , ( "master", "Right click at where you want it to go on the screen!" )
    , ( "master", "The larger the distance between your mouse and the object," )
    , ( "master", "The larger energy you will use on the object." )
    , ( "master", "And the larger the blue point is around your mouse," )
    , ( "master", "which is called the Visual Aid System." )
    , ( "master", "Also notice that," )
    , ( "master", "If the selected objects have low energy," )
    , ( "master", "You cannot grasp energy from them;" )
    , ( "master", "Similarly, you can't use low energy on objects." )
    , ( "master", "Another important rule is that, in the air," )
    , ( "master", "You cannot use energy on yourself," )
    , ( "master", "But you can still use energy on other objects." )
    , ( "p_profile", "Alright." )
    , ( "master", "There are many dangers in your journey," )
    , ( "master", "Please be cautious." )
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
    List.append
        [ ( \gd ggd ->
                renderSprite gd [] (getPositionUnderCamera ( 2140, 1520 ) ggd) ( 700, 0 ) "zy/building"
          , BehindActors
          )
        ]
        (case sp of
            0 ->
                [ ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( 2440, 1820 ) ggd) ( 100, 0 ) "master"
                  , BehindActors
                  )
                , ( \gd ggd ->
                        renderSprite gd [] (getPositionUnderCamera ( 4200, 1830 ) ggd) ( 100, 0 ) "master"
                  , BehindActors
                  )
                ]

            _ ->
                [ ( \_ _ -> group [] [], BehindActors ) ]
        )
        ++ [ ( \gd ggd -> renderText gd 30 "Use A,D to move to left and right, Use C or Space to jump" "Times New Roman" (getPositionUnderCamera ( 200, 1560 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Use Esc to call the menu" "Times New Roman" (getPositionUnderCamera ( 200, 1630 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Save Point" "Times New Roman" (getPositionUnderCamera ( 2880, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "(Also Save Energy)" "Times New Roman" (getPositionUnderCamera ( 2820, 2000 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "You can restart to go to the last savepoint" "Times New Roman" (getPositionUnderCamera ( 2820, 2060 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Energy Crystal" "Times New Roman" (getPositionUnderCamera ( 3080, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "(Recoverable)" "Times New Roman" (getPositionUnderCamera ( 3080, 1760 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Energy Crystal" "Times New Roman" (getPositionUnderCamera ( 3390, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "(Irrecoverable)" "Times New Roman" (getPositionUnderCamera ( 3390, 1760 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Hit the goomba to get on the platform!" "Times New Roman" (getPositionUnderCamera ( 3690, 1960 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Jump at the last monent" "Times New Roman" (getPositionUnderCamera ( 4200, 1360 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Press W to save the energy from the player the moment before you hit the ground!" "Times New Roman" (getPositionUnderCamera ( 4200, 1430 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Right click at the top of the screen and over the character" "Times New Roman" (getPositionUnderCamera ( 4390, 1760 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "And don't forget to move right!" "Times New Roman" (getPositionUnderCamera ( 4690, 1830 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Try to use energy on the goombas! (Move them away)" "Times New Roman" (getPositionUnderCamera ( 5390, 900 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Press E to select yourself quickly" "Times New Roman" (getPositionUnderCamera ( 6690, 900 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 50 "Challenge Exercises" "Times New Roman" (getPositionUnderCamera ( 7290, 1100 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 40 "(Optional)" "Times New Roman" (getPositionUnderCamera ( 7400, 1200 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Right click to release the energy at the correct position" "Times New Roman" (getPositionUnderCamera ( 7500, 2030 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "Try to take advantage of the visual aid system" "Times New Roman" (getPositionUnderCamera ( 7500, 2070 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 30 "(You can also turn it off in the menu)" "Times New Roman" (getPositionUnderCamera ( 7500, 2110 ) ggd), BehindActors )
           , ( \gd ggd -> renderText gd 40 "You are ready to go!" "Times New Roman" (getPositionUnderCamera ( 8900, 700 ) ggd), BehindActors )
           ]
        ++ makemanybamboos ( 70, 2093 ) 9
