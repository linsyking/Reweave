module Scenes.Home.Layer0.Models exposing (..)

import Base exposing (..)
import Constants exposing (..)
import Lib.Audio.Base exposing (AudioOption(..))
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Home.Layer0.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { s = 0
    }


updateModel : Msg -> GlobalData -> LayerMsg -> SModel -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel _ gd _ ( model, t ) cd =
    ( ( model, cd, [] ), gd )
