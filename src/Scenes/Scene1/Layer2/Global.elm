module Scenes.Scene1.Layer2.Global exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Layer.Base exposing (..)
import Scenes.Scene1.Layer2.Export exposing (Data, nullData)
import Scenes.Scene1.LayerBase exposing (CommonData)
import Scenes.Scene1.LayerSettings exposing (..)


dToCT : Data -> LayerDataType
dToCT data =
    Layer2Data data


ctTod : LayerDataType -> Data
ctTod ldt =
    case ldt of
        Layer2Data x ->
            x

        _ ->
            nullData


getLayerCT : Layer CommonData Data -> LayerCT
getLayerCT layer =
    let
        init : Int -> CommonData -> LayerDataType
        init t cd =
            dToCT (layer.init t cd)

        update : Msg -> GlobalData -> LayerMsg -> ( LayerDataType, Int ) -> CommonData -> ( ( LayerDataType, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
        update m gd lm ( ldt, t ) cd =
            let
                ( ( rldt, rcd, ltm ), newgd ) =
                    layer.update m gd lm ( ctTod ldt, t ) cd
            in
            ( ( dToCT rldt, rcd, ltm ), newgd )

        view : ( LayerDataType, Int ) -> CommonData -> GlobalData -> Renderable
        view ( ldt, t ) cd gd =
            layer.view ( ctTod ldt, t ) cd gd
    in
    Layer (dToCT layer.data) init update view
