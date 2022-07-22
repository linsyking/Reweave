module Lib.CoreEngine.BackgroundLayer.Global exposing (..)

{-| This is the doc for this module

@docs dToCT

@docs ctTod

@docs getLayerCT

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.CoreEngine.BackgroundLayer.Export exposing (Data, nullData)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.LayerSettings exposing (LayerCT, LayerDataType(..))
import Lib.Layer.Base exposing (Layer, LayerMsg, LayerTarget)


{-| dToCT
-}
dToCT : Data -> LayerDataType
dToCT data =
    BackgroundData data


{-| ctTod
-}
ctTod : LayerDataType -> Data
ctTod ldt =
    case ldt of
        BackgroundData x ->
            x

        _ ->
            nullData


{-| getLayerCT
-}
getLayerCT : Layer GameGlobalData Data -> LayerCT
getLayerCT layer =
    let
        init : Int -> LayerMsg -> GameGlobalData -> LayerDataType
        init t lm cd =
            dToCT (layer.init t lm cd)

        update : Msg -> GlobalData -> LayerMsg -> ( LayerDataType, Int ) -> GameGlobalData -> ( ( LayerDataType, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
        update m gd lm ( ldt, t ) cd =
            let
                ( ( rldt, rcd, ltm ), newgd ) =
                    layer.update m gd lm ( ctTod ldt, t ) cd
            in
            ( ( dToCT rldt, rcd, ltm ), newgd )

        view : ( LayerDataType, Int ) -> GameGlobalData -> GlobalData -> Renderable
        view ( ldt, t ) cd gd =
            layer.view ( ctTod ldt, t ) cd gd
    in
    Layer (dToCT layer.data) init update view
