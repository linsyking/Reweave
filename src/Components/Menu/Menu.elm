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
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..), dgetLComponent, dsetLComponent, findFirstFitComponentInList, setFirstFitComponentInList)
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


componentInteract : List ( String, Component ) -> List ComponentTMsg -> ComponentTMsg -> GlobalData -> ( List ( String, Component ), ComponentTMsg, GlobalData )
componentInteract comList comMsgList newMsg globalData =
    case comMsgList of
        tmpMsg :: restMsgList ->
            case tmpMsg of
                ComponentLSStringMsg demand listStr ->
                    case demand of
                        "OnShow" ->
                            let
                                showItemName =
                                    Maybe.withDefault "None" (List.head listStr)

                                newComListWithComMsgs =
                                    List.map
                                        (\( comName, comModel ) ->
                                            let
                                                ( tmpData, tmpComMsg, _ ) =
                                                    if comName == showItemName then
                                                        ( comModel.data, NullComponentMsg, globalData )

                                                    else
                                                        comModel.update UnknownMsg (ComponentStringMsg "Display:HIDE") globalData ( comModel.data, 0 )
                                            in
                                            ( ( comName, { comModel | data = tmpData } ), tmpComMsg )
                                        )
                                        comList

                                newComList =
                                    List.map (\( tmpCom, _ ) -> tmpCom) newComListWithComMsgs

                                newComMsg =
                                    Maybe.withDefault NullComponentMsg (List.head (List.map (\( _, tmpComMsg ) -> tmpComMsg) newComListWithComMsgs))
                            in
                            if newMsg == NullComponentMsg then
                                componentInteract newComList restMsgList newComMsg globalData

                            else
                                componentInteract newComList restMsgList newMsg globalData

                        _ ->
                            componentInteract comList restMsgList newMsg globalData

                _ ->
                    componentInteract comList restMsgList newMsg globalData

        _ ->
            ( comList, newMsg, globalData )


updateMenu : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMenu mainMsg comMsg globalData ( model, t ) =
    let
        childComponentsList =
            dgetLComponent model "Child"
    in
    case mainMsg of
        MouseDown _ ->
            let
                ( tmpChildComponentsList, tmpChildComponentsMsg, tmpGlobalData ) =
                    List.foldl
                        (\( comName, comModel ) ( tmpComList, tmpComMsgList, tmpGData ) ->
                            let
                                ( tmpCom, tmpComMsg, gD ) =
                                    comModel.update mainMsg comMsg tmpGData ( comModel.data, t )
                            in
                            ( List.append tmpComList [ ( comName, { comModel | data = tmpCom } ) ], List.append tmpComMsgList [ tmpComMsg ], gD )
                        )
                        ( [], [], globalData )
                        childComponentsList

                ( newChildComponentsList, newChildComponentsMsg, newGlobalData ) =
                    componentInteract tmpChildComponentsList tmpChildComponentsMsg NullComponentMsg tmpGlobalData
            in
            ( model
                |> dsetLComponent "Child" newChildComponentsList
            , newChildComponentsMsg
            , newGlobalData
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
