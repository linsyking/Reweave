module Scenes.Scene1.Layer1.Global exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Layer.Base exposing (..)
import Scenes.Scene1.Layer1.Export exposing (Data, nullData)
import Scenes.Scene1.LayerBase exposing (CommonData)
import Scenes.Scene1.LayerSettings exposing (..)


dToCT : Data -> LayerDataType
dToCT data =
    Layer1Data data


ctTod : LayerDataType -> Data
ctTod ldt =
    case ldt of
        Layer1Data x ->
            x

        _ ->
            nullData


getLayerCT : Layer CommonData Data -> LayerCT
getLayerCT layer =
    let
        init : Int -> CommonData -> LayerDataType
        init t cd =
            dToCT (layer.init t cd)

        update : Msg -> LayerMsg -> ( LayerDataType, Int ) -> CommonData -> ( LayerDataType, CommonData, ( LayerTarget, LayerMsg ) )
        update m lm ( ldt, t ) cd =
            let
                ( rldt, rcd, ( rlt, rlm ) ) =
                    layer.update m lm ( ctTod ldt, t ) cd
            in
            ( dToCT rldt, rcd, ( rlt, rlm ) )

        view : ( LayerDataType, Int ) -> CommonData -> GlobalData -> Renderable
        view ( ldt, t ) cd gd =
            layer.view ( ctTod ldt, t ) cd gd
    in
    Layer (dToCT layer.data) init update view
