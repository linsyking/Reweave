module Lib.CoreEngine.BackgroundLayer.Model exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget)


initModel : Int -> LayerMsg -> GameGlobalData -> Model
initModel _ lm _ =
    case lm of
        LayerTimeSeries f ->
            { render = f }

        _ ->
            { render = \_ _ _ -> group [] [] }


updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel _ gd _ ( model, _ ) ggd =
    ( ( model, ggd, [] ), gd )
