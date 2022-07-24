module Scenes.Home.Model exposing
    ( initModel
    , handleLayerMsg
    , updateModel
    , viewModel
    )

{-| This is the doc for this module

@docs initModel

@docs handleLayerMsg

@docs updateModel

@docs viewModel

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha, filter)
import Lib.Audio.Base exposing (AudioOption(..))
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition(..))
import Lib.Layer.Base exposing (LayerMsg(..))
import Lib.Layer.LayerHandler exposing (updateLayer, viewLayer)
import Lib.LocalStorage.LocalStorage exposing (isFirstPlay)
import Lib.Render.Render exposing (renderText)
import Lib.Scene.Base exposing (EngineT, SceneMsg(..), SceneOutputMsg(..))
import Scenes.Home.Common exposing (XModel)
import Scenes.Home.Layer0.Export as L0
import Scenes.Home.Layer0.Global as L0G
import Scenes.Home.Layer1.Export as L1
import Scenes.Home.Layer1.Global as L1G


{-| initModel
-}
initModel : Int -> SceneMsg -> XModel
initModel t _ =
    let
        icd =
            { started = False
            , presstime = 0
            }

        l0l =
            L0.layer

        l0ct =
            L0G.getLayerCT { l0l | data = L0.layer.init t NullLayerMsg icd }

        l1l =
            L1.layer

        l1ct =
            L1G.getLayerCT { l1l | data = L1.layer.init t NullLayerMsg icd }
    in
    { commonData = icd
    , layers =
        [ ( "Layer0", l0ct )
        , ( "Layer1", l1ct )
        ]
    }


{-| handleLayerMsg
-}
handleLayerMsg : GlobalData -> LayerMsg -> ( XModel, Int ) -> ( XModel, SceneOutputMsg )
handleLayerMsg gd lmsg ( model, _ ) =
    case lmsg of
        LayerIntMsg i ->
            if i == 1 then
                ( model, SOChangeScene ( NullSceneMsg, "Level0" ) )

            else if i == 2 then
                ( model, SOPlayAudio "bgm" "./assets/audio/music.mp3" ALoop )

            else if i == 3 then
                if gd.localstorage.initPosition == ( -1, -1 ) then
                    ( model, SOChangeScene ( SceneEngineTMsg (EngineT gd.localstorage.energy DefaultPlayerPosition gd.localstorage.collected 0), gd.localstorage.level ) )

                else
                    ( model, SOChangeScene ( SceneEngineTMsg (EngineT gd.localstorage.energy (CustomPlayerPosition gd.localstorage.initPosition) gd.localstorage.collected 0), gd.localstorage.level ) )

            else
                ( model, NullSceneOutputMsg )

        _ ->
            ( model, NullSceneOutputMsg )


{-| updateModel
-}
updateModel : Msg -> GlobalData -> ( XModel, Int ) -> ( XModel, SceneOutputMsg, GlobalData )
updateModel msg gd ( model, t ) =
    let
        ( ( newdata, newcd, msgs ), newgd ) =
            updateLayer msg gd t model.commonData model.layers

        nmodel =
            { model | commonData = newcd, layers = newdata }

        ( newmodel, newso ) =
            List.foldl (\x ( y, _ ) -> handleLayerMsg gd x ( y, t )) ( nmodel, NullSceneOutputMsg ) msgs
    in
    ( newmodel, newso, newgd )


{-| viewModel
-}
viewModel : ( XModel, Int ) -> GlobalData -> Renderable
viewModel ( model, t ) gd =
    let
        pt =
            model.commonData.presstime

        elapse =
            t - pt
    in
    if model.commonData.started && elapse > 30 then
        viewLayer gd t model.commonData model.layers

    else if model.commonData.started then
        group [ filter ("blur(" ++ String.fromInt (30 - elapse) ++ "px)") ]
            [ viewLayer gd t model.commonData model.layers
            ]

    else
        group []
            [ group [ filter "blur(30px)" ]
                [ viewLayer gd t model.commonData model.layers
                ]
            , starttext t gd
            ]


starttext : Int -> GlobalData -> Renderable
starttext t gd =
    group [ alpha (0.7 + sin (toFloat t / 10) / 3) ]
        (List.append
            [ renderText gd 60 "Click anywhere to start" "Times New Roman" ( 650, 900 )
            ]
            (if isFirstPlay gd.localstorage then
                [ renderText gd 60 "Tips: This game features auto-save system" "Times New Roman" ( 450, 400 )
                , renderText gd 60 "You don't have to finish the game in one run" "Times New Roman" ( 430, 480 )
                ]

             else
                []
            )
        )
