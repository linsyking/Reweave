module Components.Menu.Menu exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Components.Menu.Status.Export as MenuStatusE
import Constants exposing (..)
import Dict exposing (Dict)
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..), dgetLComponent, dgetfloat, dsetLComponent, dsetfloat)
import Lib.Coordinate.Coordinates exposing (..)


initMenu : Int -> ComponentTMsg -> Data
initMenu _ _ =
    Dict.fromList
        [ ( "Status", CDLComponent [ MenuStatusE.initComponent 0 NullComponentMsg ] )
        ]


updateMenu : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMenu mainMsg comMsg globalData ( model, t ) =
    let
        status =
            Maybe.withDefault MenuStatusE.component (List.head (dgetLComponent model "Status"))
    in
    case mainMsg of
        MouseDown _ ->
            let
                ( newStatusData, statusComMsg, newGlobalData ) =
                    status.update mainMsg NullComponentMsg globalData ( status.data, t )
            in
            ( model
                |> dsetLComponent "Status" [ { status | data = newStatusData } ]
            , NullComponentMsg
            , globalData
            )

        _ ->
            ( model, NullComponentMsg, globalData )


viewMenu : ( Data, Int ) -> GlobalData -> Renderable
viewMenu ( model, t ) globalData =
    let
        status =
            Maybe.withDefault MenuStatusE.component (List.head (dgetLComponent model "Status"))
    in
    status.view ( status.data, t ) globalData
