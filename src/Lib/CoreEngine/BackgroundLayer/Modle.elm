module Lib.CoreEngine.BackgroundLayer.Modle exposing (..)

import Base exposing (GlobalData, Msg)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Layer.Base exposing (LayerMsg, LayerTarget)


initModel : Int -> GameGlobalData -> Model
initModel _ _ =
    { k = 0 }


updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel _ gd _ ( model, _ ) ggd =
    ( ( model, ggd, [] ), gd )
