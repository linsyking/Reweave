module Components.Menu.Menu exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Components.Menu.Map.Export as MenuMapE
import Components.Menu.Settings.Export as MenuSettingsE
import Components.Menu.Status.Export as MenuStatusE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..), dgetLComponent, dsetLComponent, findFirstFitComponentInList, setFirstFitComponentInList)
import Lib.Coordinate.Coordinates exposing (..)


initMenu : Int -> ComponentTMsg -> Data
initMenu _ _ =
    Dict.fromList
        [ ( "Child"
          , CDLComponent
                [ ( "Status", MenuStatusE.initComponent 0 NullComponentMsg )
                , ( "Settings", MenuSettingsE.initComponent 0 NullComponentMsg )
                , ( "Map", MenuMapE.initComponent 0 NullComponentMsg )
                ]
          )
        ]


updateMenu : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMenu mainMsg comMsg globalData ( model, t ) =
    let
        childComponentsList =
            dgetLComponent model "Child"

        ( statusName, status ) =
            findFirstFitComponentInList "Status" childComponentsList

        ( settingsName, settings ) =
            findFirstFitComponentInList "Settings" childComponentsList

        ( mapName, map ) =
            findFirstFitComponentInList "Map" childComponentsList
    in
    case mainMsg of
        MouseDown _ ->
            let
                ( newStatusData, statusComMsg, newGlobalData1 ) =
                    status.update mainMsg NullComponentMsg globalData ( status.data, t )

                ( newSettingsData, settingsComMsg, newGlobalData2 ) =
                    settings.update mainMsg NullComponentMsg newGlobalData1 ( settings.data, t )

                ( newMapData, mapComMsg, newGlobalData3 ) =
                    map.update mainMsg NullComponentMsg newGlobalData2 ( map.data, t )
            in
            ( model
                |> dsetLComponent "Child"
                    (childComponentsList
                        |> setFirstFitComponentInList "Status" ( "Status", { status | data = newStatusData } )
                        |> setFirstFitComponentInList "Settings" ( "Settings", { settings | data = newSettingsData } )
                        |> setFirstFitComponentInList "Map" ( "Map", { map | data = newMapData } )
                    )
            , NullComponentMsg
            , globalData
            )

        _ ->
            ( model, NullComponentMsg, globalData )


viewMenu : ( Data, Int ) -> GlobalData -> Renderable
viewMenu ( model, t ) globalData =
    let
        childComponentsList =
            dgetLComponent model "Child"

        ( statusName, status ) =
            findFirstFitComponentInList "Status" childComponentsList

        ( settingsName, settings ) =
            findFirstFitComponentInList "Settings" childComponentsList

        ( mapName, map ) =
            findFirstFitComponentInList "Map" childComponentsList
    in
    group []
        [ status.view ( status.data, t ) globalData
        , settings.view ( settings.data, t ) globalData
        , map.view ( map.data, t ) globalData
        ]
