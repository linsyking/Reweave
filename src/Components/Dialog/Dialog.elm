module Components.Dialog.Dialog exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetDict, dgetLComponent, dgetbool, dsetLComponent, dsetbool, dsetstring)
import Lib.Render.Render exposing (renderText)



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild)


initDialog : Int -> ComponentTMsg -> Data
initDialog _ comMsg =
    case comMsg of
        ComponentDictMsg dict ->
            dict
                |> dsetstring "_Status" "OnBuild"
                |> dsetLComponent "_Child" []

        _ ->
            Dict.empty


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


updateDialog : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateDialog mainMsg comMsg globalData ( model, t ) =
    let
        childComponentsList =
            dgetLComponent model "Child"

        showStatus =
            dgetbool model "Show"
    in
    case mainMsg of
        MouseDown _ ( x, y ) ->
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
            if judgeMouse globalData ( x, y ) ( 1100 - 30, 400 - 30 ) ( 2 * 30, 2 * 30 ) then
                ( model
                    |> dsetbool "Show" False
                , NullComponentMsg
                , globalData
                )

            else if showStatus then
                ( model
                    |> dsetLComponent "Child" newChildComponentsList
                , newChildComponentsMsg
                , newGlobalData
                )

            else
                ( model, NullComponentMsg, globalData )

        _ ->
            case comMsg of
                ComponentLStringMsg (demand :: _ :: _) ->
                    case demand of
                        "Activate" ->
                            let
                                tmpData =
                                    dgetDict model "Data"

                                ( newChildComponentsList, _, newGlobalData ) =
                                    List.foldl
                                        (\( comName, comModel ) ( tmpComList, tmpComMsgList, tmpGData ) ->
                                            let
                                                ( tmpCom, tmpComMsg, gD ) =
                                                    comModel.update mainMsg (ComponentDictMsg tmpData) tmpGData ( comModel.data, t )
                                            in
                                            ( List.append tmpComList [ ( comName, { comModel | data = tmpCom } ) ], List.append tmpComMsgList [ tmpComMsg ], gD )
                                        )
                                        ( [], [], globalData )
                                        childComponentsList
                            in
                            ( model
                                |> dsetbool "Show" True
                                |> dsetLComponent "Child" newChildComponentsList
                            , NullComponentMsg
                            , newGlobalData
                            )

                        _ ->
                            ( model, NullComponentMsg, globalData )

                _ ->
                    ( model, NullComponentMsg, globalData )


viewDialog : ( Data, Int ) -> GlobalData -> Renderable
viewDialog ( model, t ) globalData =
    let
        childComponentsList =
            dgetLComponent model "Child"

        showStatus =
            dgetbool model "Show"
    in
    if showStatus then
        group []
            (List.append
                [ shapes [ stroke Color.black ]
                    [ rect (posToReal globalData ( 400, 300 )) (widthToReal globalData 800) (heightToReal globalData 500)
                    , circle (posToReal globalData ( 1100, 400 )) (widthToReal globalData 30)
                    ]
                , renderText globalData 50 "X" "sans-serif" ( 1100 - 15, 400 - 30 )
                ]
                (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
            )

    else
        group [] []
