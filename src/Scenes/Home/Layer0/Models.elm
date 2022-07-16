module Scenes.Home.Layer0.Models exposing (..)

--- Init a model, and update it

import Base exposing (..)
import Constants exposing (..)
import Lib.Audio.Base exposing (AudioOption(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Home.Layer0.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { s = 0
    }


updateModel : Msg -> GlobalData -> LayerMsg -> SModel -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) cd =
    ( ( model, cd, [] ), gd )

