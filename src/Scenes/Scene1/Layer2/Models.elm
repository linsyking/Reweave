module Scenes.Scene1.Layer2.Models exposing (..)

--- Init a model, and update it

import Array
import Base exposing (..)
import Components.Bar.Export as ComBarE
import Constants exposing (..)
import Lib.Audio.Base exposing (AudioOption(..))
import Lib.Component.Base exposing (ComponentTMsg(..))
import Lib.Component.ComponentHandler exposing (updateComponents, updateSingleComponent)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Layer2.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


initModel : Int -> CommonData -> ModelX
initModel _ _ =
    { components = [ ComBarE.initComponent 0 NullComponentMsg ]
    }


updateModel : Msg -> GlobalData -> LayerMsg -> SModel -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) cd =
    case msg of
        Tick _ ->
            let
                components =
                    model.components

                ( newComponents, _, _ ) =
                    if t == 100 then
                        updateSingleComponent msg (ComponentIntMsg 50) gd t 0 (Array.fromList components)

                    else
                        updateSingleComponent msg NullComponentMsg gd t 0 (Array.fromList components)
            in
            ( ( { model | components = Array.toList newComponents }, cd, [] ), gd )

        _ ->
            ( ( model, cd, [] ), gd )



-- case msg of
--     KeyDown _ ->
--         ( model, cd, ( LayerParentScene, LayerSoundMsg "se" "./assets/audio/Eaten.ogg" AOnce ) )
--         -- ( model, cd, ( LayerParentScene, LayerStopSoundMsg "bgm" ) )
--     _ ->
--         if t == 200 then
--             ( model, cd, ( LayerParentScene, LayerSoundMsg "bgm" "./assets/audio/main.ogg" ALoop ) )
--         else
