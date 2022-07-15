module Scenes.Scene1.Layer1.Models exposing (..)

--- Init a model, and update it

import Base exposing (..)
import Constants exposing (..)
import Lib.Audio.Base exposing (AudioOption(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Layer1.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { s = 0
    }


updateModel : Msg -> GlobalData -> LayerMsg -> SModel -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) cd =
    case msg of
        MouseDown 1 ( x, y ) ->
            -- Test code for mouse down and judgemouse
            if judgeMouse gd ( x, y ) ( 100, 100 ) ( 100, 100 ) then
                ( ( model, cd, [] ), gd )

            else
                ( ( model, cd, [] ), gd )

        _ ->
            if t == 200 then
                Debug.log "Audio" ( ( model, cd, [ ( LayerParentScene, LayerSoundMsg "bgm" "./assets/audio/main.ogg" ALoop ) ] ), gd )

            else
                ( ( model, cd, [] ), gd )



-- case msg of
--     KeyDown _ ->
--         ( model, cd, ( LayerParentScene, LayerSoundMsg "se" "./assets/audio/Eaten.ogg" AOnce ) )
--         -- ( model, cd, ( LayerParentScene, LayerStopSoundMsg "bgm" ) )
--     _ ->
--         if t == 200 then
--             ( model, cd, ( LayerParentScene, LayerSoundMsg "bgm" "./assets/audio/main.ogg" ALoop ) )
--         else
