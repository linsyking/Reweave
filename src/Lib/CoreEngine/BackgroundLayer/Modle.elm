module Lib.CoreEngine.BackgroundLayer.Modle exposing (..)

import Base exposing (GlobalData, Msg)
import Lib.CoreEngine.BackgroundLayer.Common exposing (Model)
import Lib.CoreEngine.Base exposing (GameGloablData)
import Lib.Layer.Base exposing (LayerMsg, LayerTarget)


initModel : Int -> GameGloablData -> Model
initModel _ _ =
    { k = 0 }


updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGloablData -> ( ( Model, GameGloablData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel _ gd _ ( model, _ ) ggd =
    ( ( model, ggd, [] ), gd )
