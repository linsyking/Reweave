module Components.Menu.Menu exposing
    ( testData
    , initMenu
    , componentInteract
    , updateMenu
    , viewMenu
    )

{-| This is the doc for this module

@docs testData

@docs initMenu

@docs componentInteract

@docs updateMenu

@docs viewMenu

-}

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Components.Menu.Map.Export as MenuMapE
import Components.Menu.Settings.Export as MenuSettingsE
import Components.Menu.Status.Export as MenuStatusE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetbool, dsetLComponent, dsetbool)
import Lib.Render.Render exposing (renderSprite)


{-| testData
-}
testData : Dict.Dict String DefinedTypes
testData =
    Dict.fromList
        [ ( "CharLife", CDInt 5 )
        , ( "CharEnergy", CDFloat 50.5 )
        , ( "CharPositionX", CDFloat 400 )
        , ( "CharPositionY", CDFloat 30 )
        , ( "MapWidth", CDFloat 1000 )
        , ( "MapHeight", CDFloat 500 )
        ]


{-| initMenu
-}
initMenu : Int -> ComponentTMsg -> Data
initMenu _ _ =
    Dict.fromList
        [ ( "Show", CDBool False )
        , ( "Child"
          , CDLComponent
                [ ( "Status", MenuStatusE.initComponent 0 NullComponentMsg )
                , ( "Settings", MenuSettingsE.initComponent 0 NullComponentMsg )
                , ( "Map", MenuMapE.initComponent 0 NullComponentMsg )
                ]
          )
        , ( "Data", CDDict testData )
        ]


{-| componentInteract
-}
componentInteract : List ( String, Component ) -> List ComponentTMsg -> ComponentTMsg -> GlobalData -> ( List ( String, Component ), List ComponentTMsg, GlobalData )
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
                                                        ( comModel.data, [], globalData )

                                                    else
                                                        comModel.update UnknownMsg (ComponentStringMsg "Display:HIDE") globalData ( comModel.data, 0 )
                                            in
                                            ( ( comName, { comModel | data = tmpData } ), tmpComMsg )
                                        )
                                        comList

                                newComList =
                                    List.map (\( tmpCom, _ ) -> tmpCom) newComListWithComMsgs

                                newComMsg =
                                    Maybe.withDefault NullComponentMsg (List.head (List.concat (List.map (\( _, tmpComMsg ) -> tmpComMsg) newComListWithComMsgs)))
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
            ( comList, [ newMsg ], globalData )


{-| updateMenu
-}
updateMenu : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateMenu mainMsg comMsg globalData ( model, t ) =
    let
        childComponentsList =
            dgetLComponent model "Child"

        showStatus =
            dgetbool model "Show"
    in
    case mainMsg of
        MouseDown _ _ ->
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

                ( newChildComponentsList, tmpChildComponentsMsg1, newGlobalData ) =
                    componentInteract tmpChildComponentsList (List.concat tmpChildComponentsMsg) NullComponentMsg tmpGlobalData

                newChildComponentsMsg =
                    List.append
                        (List.filter
                            (\tmpMsg ->
                                case tmpMsg of
                                    ComponentLStringMsg _ ->
                                        True

                                    _ ->
                                        False
                            )
                            (List.concat tmpChildComponentsMsg)
                        )
                        (List.filter
                            (\tmpMsg ->
                                case tmpMsg of
                                    NullComponentMsg ->
                                        False

                                    _ ->
                                        True
                            )
                            tmpChildComponentsMsg1
                        )
            in
            -- if judgeMouse globalData ( x, y ) ( 1100 - 30, 400 - 30 ) ( 2 * 30, 2 * 30 ) then
            -- ( model
            --     |> dsetbool "Show" False
            -- , [ ComponentStringMsg "OnClose" ]
            -- , globalData
            -- )
            -- else
            case newChildComponentsMsg of
                (ComponentLStringMsg ("continue" :: _)) :: _ ->
                    ( model
                        |> dsetbool "Show" False
                    , [ ComponentLStringMsg [ "continue" ] ]
                    , globalData
                    )

                (ComponentLStringMsg ("restart" :: _)) :: _ ->
                    ( model
                        |> dsetbool "Show" False
                    , [ ComponentLStringMsg [ "restart" ] ]
                    , globalData
                    )

                _ ->
                    if showStatus then
                        ( model
                            |> dsetLComponent "Child" newChildComponentsList
                        , newChildComponentsMsg
                        , newGlobalData
                        )

                    else
                        ( model, [], globalData )

        _ ->
            case comMsg of
                ComponentStringDictMsg demand dict ->
                    case demand of
                        "Activate" ->
                            let
                                ( newChildComponentsList, _, newGlobalData ) =
                                    List.foldl
                                        (\( comName, comModel ) ( tmpComList, tmpComMsgList, tmpGData ) ->
                                            let
                                                ( tmpCom, tmpComMsg, gD ) =
                                                    comModel.update mainMsg (ComponentStringDictMsg "Init" dict) tmpGData ( comModel.data, t )
                                            in
                                            ( List.append tmpComList [ ( comName, { comModel | data = tmpCom } ) ], List.append tmpComMsgList [ tmpComMsg ], gD )
                                        )
                                        ( [], [], globalData )
                                        childComponentsList
                            in
                            ( model
                                |> dsetbool "Show" True
                                |> dsetLComponent "Child" newChildComponentsList
                            , []
                            , newGlobalData
                            )

                        "Close" ->
                            let
                                ( newChildComponentsList, _, _ ) =
                                    List.foldl
                                        (\( comName, comModel ) ( tmpComList, tmpComMsgList, tmpGData ) ->
                                            let
                                                ( tmpCom, tmpComMsg, gD ) =
                                                    comModel.update mainMsg (ComponentStringMsg "Display:HIDE") tmpGData ( comModel.data, t )
                                            in
                                            ( List.append tmpComList [ ( comName, { comModel | data = tmpCom } ) ], List.append tmpComMsgList [ tmpComMsg ], gD )
                                        )
                                        ( [], [], globalData )
                                        childComponentsList
                            in
                            ( model
                                |> dsetbool "Show" False
                                |> dsetLComponent "Child" newChildComponentsList
                            , [ ComponentStringMsg "OnClose" ]
                            , globalData
                            )

                        _ ->
                            ( model, [], globalData )

                _ ->
                    ( model, [], globalData )


{-| viewMenu
-}
viewMenu : ( Data, Int ) -> GlobalData -> Renderable
viewMenu ( model, t ) globalData =
    let
        childComponentsList =
            dgetLComponent model "Child"

        showStatus =
            dgetbool model "Show"
    in
    if showStatus then
        group []
            (List.append
                [ --  shapes [ stroke Color.black ]
                  -- [ rect (posToReal globalData ( 400, 300 )) (widthToReal globalData 800) (heightToReal globalData 500)
                  -- ],
                  renderSprite globalData [] ( 400, 300 ) ( 1120, 500 ) "scroll"
                ]
                (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
            )

    else
        group [] []
