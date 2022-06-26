module Scenes.Scene1.Layer1.Models exposing (..)

--- Init a model, and update it

import Base exposing (..)
import Constants exposing (..)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Layer1.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


initModel : Int -> CommonData -> ModelX
initModel _ _ =
    { s = 0
    }


updateModel : Msg -> LayerMsg -> SModel -> CommonData -> ( ModelX, CommonData, ( LayerTarget, LayerMsg ) )
updateModel _ _ ( model, t ) cd =
    ( model, cd, ( NullLayerTarget, NullLayerMsg ) )
