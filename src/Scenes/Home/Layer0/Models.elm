module Scenes.Home.Layer0.Models exposing (..)

{-| This is the doc for this module

@docs initModel

@docs updateModel

-}

import Base exposing (..)
import Constants exposing (..)
import Lib.Audio.Base exposing (AudioOption(..))
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Home.Layer0.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)


{-| initModel
-}
initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { s = 0
    }


{-| updateModel
-}
updateModel : Msg -> GlobalData -> LayerMsg -> SModel -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel _ gd _ ( model, t ) cd =
    ( ( model, cd, [] ), gd )
