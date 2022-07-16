module Scenes.Home.Layer1.Models exposing (..)

--- Init a model, and update it

import Base exposing (..)
import Constants exposing (..)
import Lib.Component.Base exposing (ComponentTMsg(..))
import Lib.Component.ComponentHandler exposing (updateSingleComponent)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (..)
import Scenes.Home.Layer1.Common exposing (..)
import Scenes.Home.LayerBase exposing (CommonData)
import Lib.Coordinate.Coordinates exposing (..)

width = 60
height = 40

initButton : String -> ( Int, Int ) -> Int -> Int -> Button
initButton description ( w, h ) wid hgt =
    Button description ( w, h ) wid hgt

initModel : Int -> LayerMsg -> CommonData -> ModelX
initModel _ _ _ =
    { ico = 1
    , start = initButton "Start" ( 930, 500 ) width height
    , help = initButton "Help" ( 930, 600 ) width height
    , map = initButton "Map" ( 930, 700 ) width height
    }

updateModel : Msg -> GlobalData -> LayerMsg -> (ModelX, Int) -> CommonData -> ( ( ModelX, CommonData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd _ ( model, t ) cd =
    case msg of

        MouseDown 0 ( x, y ) ->
            if judgeMouse gd ( x, y ) ( Tuple.first model.start.pos, Tuple.second model.start.pos ) ( width * 2, height * 2 ) then
                ( ( model, cd, [( LayerParentScene, LayerIntMsg 1 )] ), gd )

            else if judgeMouse gd ( x, y ) ( Tuple.first model.help.pos, Tuple.second model.help.pos ) ( width * 2, height * 2 ) then
                ( ( model, cd, [( LayerParentScene, LayerIntMsg 2 )] ), gd)
            
            else if judgeMouse gd ( x, y ) ( Tuple.first model.map.pos, Tuple.second model.map.pos ) ( width * 2, height * 2 ) then
                ( ( model, cd, [( LayerParentScene, LayerIntMsg 3 )] ), gd)
            
            else
                ( ( model, cd, [( NullLayerTarget, NullLayerMsg )] ), gd )

        _ ->
            ( ( model, cd, [( NullLayerTarget, NullLayerMsg )] ), gd )