module Lib.CoreEngine.BackgroundLayer.Global exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.CoreEngine.BackgroundLayer.Export exposing (Data, nullData)
import Lib.CoreEngine.Base exposing (GameGloablData)
import Lib.CoreEngine.LayerSettings exposing (LayerCT, LayerDataType(..))
import Lib.Layer.Base exposing (Layer, LayerMsg, LayerTarget)


dToCT : Data -> LayerDataType
dToCT data =
    BackgroundData data


ctTod : LayerDataType -> Data
ctTod ldt =
    case ldt of
        BackgroundData x ->
            x

        _ ->
            nullData


getLayerCT : Layer GameGloablData Data -> LayerCT
getLayerCT layer =
    let
        init : Int -> GameGloablData -> LayerDataType
        init t cd =
            dToCT (layer.init t cd)

        update : Msg -> GlobalData -> LayerMsg -> ( LayerDataType, Int ) -> GameGloablData -> ( ( LayerDataType, GameGloablData, List ( LayerTarget, LayerMsg ) ), GlobalData )
        update m gd lm ( ldt, t ) cd =
            let
                ( ( rldt, rcd, ltm ), newgd ) =
                    layer.update m gd lm ( ctTod ldt, t ) cd
            in
            ( ( dToCT rldt, rcd, ltm ), newgd )

        view : ( LayerDataType, Int ) -> GameGloablData -> GlobalData -> Renderable
        view ( ldt, t ) cd gd =
            layer.view ( ctTod ldt, t ) cd gd
    in
    Layer (dToCT layer.data) init update view
