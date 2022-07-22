module Scenes.Home.Layer1.Models exposing (..)

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
    40


{-| initButton
-}
initButton : String -> ( Int, Int ) -> Int -> Int -> Button
initButton description ( x, y ) len wid =
    Button description ( x, y ) len wid


{-| initModel
-}
initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { ico = 1
    , start = initButton "Start" ( 930, 500 ) length width
    , help = initButton "Help" ( 930, 600 ) length width
    , map = initButton "Map" ( 930, 700 ) length width
    }


{-| updateModel
-}
updateModel : Msg -> GlobalData -> LayerMsg -> ( ModelX, Int ) -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) cd =
    case msg of
        MouseDown 0 ( x, y ) ->
            if judgeMouse gd ( x, y ) ( Tuple.first model.start.pos, Tuple.second model.start.pos ) ( length * 2, width * 2 ) then
                ( ( model, cd, [ ( LayerParentScene, LayerIntMsg 1 ) ] ), gd )

            else if judgeMouse gd ( x, y ) ( Tuple.first model.help.pos, Tuple.second model.help.pos ) ( length * 2, width * 2 ) then
                ( ( model, cd, [ ( LayerParentScene, LayerIntMsg 2 ) ] ), gd )

            else if judgeMouse gd ( x, y ) ( Tuple.first model.map.pos, Tuple.second model.map.pos ) ( length * 2, width * 2 ) then
                ( ( model, cd, [ ( LayerParentScene, LayerIntMsg 3 ) ] ), gd )

            else
                ( ( model, cd, [ ( NullLayerTarget, NullLayerMsg ) ] ), gd )

        _ ->
            ( ( model, cd, [ ( NullLayerTarget, NullLayerMsg ) ] ), gd )
