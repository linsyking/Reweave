module Scenes.Home.Layer1.Models exposing
    ( length
    , width
    , initButton
    , initModel
    , updateModel
    )

{-| This is the doc for this module

@docs length

@docs width

@docs initButton

@docs initModel

@docs updateModel

-}

import Base exposing (..)
import Constants exposing (..)
import Lib.Component.Base exposing (ComponentTMsg(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Home.Layer1.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)



-- The length of the button is length * 2
-- The width of the button is width * 2


{-| length
-}
length : number
length =
    60


{-| width
-}
width : number
width =
    80


{-| initButton
-}
initButton : String -> ( Int, Int ) -> Int -> Int -> Button
initButton description ( x, y ) len wid =
    Button description ( x, y ) len wid


{-| initModel
-}
initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { start = initButton "Start" ( 890, 920 ) length width
    }


{-| updateModel
-}
updateModel : Msg -> GlobalData -> LayerMsg -> ( ModelX, Int ) -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) cd =
    if cd.started then
        case msg of
            MouseDown 0 ( x, y ) ->
                if judgeMouse gd ( x, y ) ( Tuple.first model.start.pos, Tuple.second model.start.pos ) ( length * 2, width ) then
                    ( ( model, cd, [ ( LayerParentScene, LayerIntMsg 1 ) ] ), gd )

                else
                    ( ( model, cd, [ ( NullLayerTarget, NullLayerMsg ) ] ), gd )

            _ ->
                ( ( model, cd, [ ( NullLayerTarget, NullLayerMsg ) ] ), gd )

    else
        case msg of
            MouseDown 0 ( x, y ) ->
                if judgeMouse gd ( x, y ) ( 0, 0 ) ( 1920, 1080 ) then
                    ( ( model, { cd | started = True }, [ ( LayerParentScene, LayerIntMsg 2 ) ] ), gd )

                else
                    ( ( model, cd, [ ( NullLayerTarget, NullLayerMsg ) ] ), gd )

            _ ->
                ( ( model, cd, [ ( NullLayerTarget, NullLayerMsg ) ] ), gd )
