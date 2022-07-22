module Scenes.Scene1.Model exposing (..)

{-| This is the doc for this module

@docs initModel

@docs handleLayerMsg

@docs updateModel

@docs viewModel

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Layer.Base exposing (LayerMsg(..))
import Lib.Layer.LayerHandler exposing (updateLayer, viewLayer)
import Lib.Scene.Base exposing (SceneMsg(..), SceneOutputMsg(..))
import Scenes.Scene1.Common exposing (XModel)
import Scenes.Scene1.Layer1.Export as L1
import Scenes.Scene1.Layer1.Global as L1G
import Scenes.Scene1.Layer2.Export as L2
import Scenes.Scene1.Layer2.Global as L2G


{-| initModel
-}
initModel : Int -> SceneMsg -> XModel
initModel t _ =
    let
        icd =
            { plt = 0
            }

        l1l =
            L1.layer

        l1ct =
            L1G.getLayerCT { l1l | data = L1.layer.init t NullLayerMsg icd }

        l2l =
            L2.layer

        l2ct =
            L2G.getLayerCT { l2l | data = L2.layer.init t NullLayerMsg icd }
    in
    { commonData = icd
    , layers =
        [ ( "Layer1", l1ct )
        , ( "Layer2", l2ct )
        ]
    }


{-| handleLayerMsg
-}
handleLayerMsg : LayerMsg -> ( XModel, Int ) -> ( XModel, SceneOutputMsg )
handleLayerMsg lmsg ( model, _ ) =
    case lmsg of
        LayerStringMsg str ->
            if str == "Restart" then
                ( model, SOChangeScene ( NullSceneMsg, "Scene1" ) )

            else
                ( model, NullSceneOutputMsg )

        LayerSoundMsg name path opt ->
            ( model, SOPlayAudio name path opt )

        LayerStopSoundMsg name ->
            ( model, SOStopAudio name )

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
            List.foldl (\x ( y, _ ) -> handleLayerMsg x ( y, t )) ( nmodel, NullSceneOutputMsg ) msgs
    in
    ( newmodel, newso, newgd )


{-| viewModel
-}
viewModel : ( XModel, Int ) -> GlobalData -> Renderable
viewModel ( model, t ) gd =
    viewLayer gd t model.commonData model.layers
