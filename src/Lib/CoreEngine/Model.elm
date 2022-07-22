module Lib.CoreEngine.Model exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.CoreEngine.BackgroundLayer.Export as BGL
import Lib.CoreEngine.BackgroundLayer.Global as BGLG
import Lib.CoreEngine.Base exposing (nullGameGlobalData, testGameGlobalData)
import Lib.CoreEngine.Common exposing (Model)
import Lib.CoreEngine.FrontgroundLayer.Base exposing (CTInfo)
import Lib.CoreEngine.FrontgroundLayer.Export as FGL
import Lib.CoreEngine.FrontgroundLayer.Global as FGLG
import Lib.CoreEngine.GameLayer.Export as GL
import Lib.CoreEngine.GameLayer.Global as GLG
import Lib.Layer.Base exposing (GameLayerInit, LayerMsg(..))
import Lib.Layer.LayerHandler exposing (updateLayer, viewLayer)
import Lib.Scene.Base exposing (SceneMsg(..), SceneOutputMsg(..))


initModel : Int -> SceneMsg -> Model
initModel t sm =
    case sm of
        SceneEngineMsg engine ->
            let
                fgl =
                    FGL.layer

                fgct =
                    FGLG.getLayerCT { fgl | data = FGL.layer.init t (LayerCTMsg (CTInfo (Tuple.first engine.frontground) (Tuple.second engine.frontground))) nullGameGlobalData }

                bgl =
                    BGL.layer

                bgct =
                    BGLG.getLayerCT { bgl | data = BGL.layer.init t (LayerCTMsg (CTInfo (Tuple.first engine.background) (Tuple.second engine.background))) nullGameGlobalData }

                gl =
                    GL.layer

                gct =
                    GLG.getLayerCT { gl | data = GL.layer.init t (LayerInitGameLayer (GameLayerInit engine.player engine.actors engine.chartlets)) nullGameGlobalData }
            in
            { gameGlobalData = engine.globalData
            , layers = [ ( "Background", bgct ), ( "Game", gct ), ( "Frontground", fgct ) ]
            }

        _ ->
            let
                fgl =
                    FGL.layer

                fgct =
                    FGLG.getLayerCT { fgl | data = FGL.layer.init t NullLayerMsg nullGameGlobalData }

                bgl =
                    BGL.layer

                bgct =
                    BGLG.getLayerCT { bgl | data = BGL.layer.init t NullLayerMsg nullGameGlobalData }

                gl =
                    GL.layer

                gct =
                    GLG.getLayerCT { gl | data = GL.layer.init t NullLayerMsg nullGameGlobalData }
            in
            { gameGlobalData = testGameGlobalData
            , layers = [ ( "Background", bgct ), ( "Game", gct ), ( "Frontground", fgct ) ]
            }


handleLayerMsg : LayerMsg -> ( Model, Int ) -> ( Model, SceneOutputMsg )
handleLayerMsg lmsg ( model, _ ) =
    case lmsg of
        LayerSoundMsg name path opt ->
            ( model, SOPlayAudio name path opt )

        LayerStopSoundMsg name ->
            ( model, SOStopAudio name )

        LayerExitMsg et ss _ ->
            ( model, SOChangeScene ( SceneEngineTMsg et, ss ) )

        _ ->
            ( model, NullSceneOutputMsg )


updateModel : Msg -> GlobalData -> ( Model, Int ) -> ( Model, SceneOutputMsg, GlobalData )
updateModel msg gd ( model, t ) =
    let
        ( ( newdata, newcd, msgs ), newgd ) =
            updateLayer msg gd t model.gameGlobalData model.layers

        nmodel =
            { model | gameGlobalData = newcd, layers = newdata }

        ( newmodel, newso ) =
            List.foldl (\x ( y, _ ) -> handleLayerMsg x ( y, t )) ( nmodel, NullSceneOutputMsg ) msgs
    in
    ( newmodel, newso, newgd )


viewModel : ( Model, Int ) -> GlobalData -> Renderable
viewModel ( model, t ) gd =
    viewLayer gd t model.gameGlobalData model.layers
