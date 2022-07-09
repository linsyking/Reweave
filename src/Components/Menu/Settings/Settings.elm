module Components.Menu.Settings.Settings exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Components.Menu.Settings.Audio.Export as MenuSetAudioE
import Constants exposing (..)
import Dict exposing (Dict)
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..), dgetLComponent, dgetbool, dgetfloat, dgetint, dsetLComponent, dsetbool)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (..)


initSettings : Int -> ComponentTMsg -> Data
initSettings _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "posX", CDInt 1650 )
        , ( "posY", CDInt 50 )
        , ( "radius", CDInt 30 )
        , ( "Child"
          , CDLComponent
                [ ( "AudioDown", MenuSetAudioE.initComponent 0 (ComponentStringMsg "AudioDown") )
                , ( "AudioUp", MenuSetAudioE.initComponent 0 (ComponentStringMsg "AudioUp") )
                ]
          )
        ]


updateSettings : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateSettings mainMsg comMsg globalData ( model, t ) =
    let
        showStatus =
            dgetbool model "show"

        reverseShowStatus =
            if dgetbool model "show" then
                False

            else
                True

        posX =
            dgetint model "posX"

        posY =
            dgetint model "posY"

        radius =
            dgetint model "radius"

        childComponentsList =
            dgetLComponent model "Child"

        ( tmpChildComponentsList, tmpChildComponentsMsg, newGlobalData ) =
            if showStatus == True then
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

            else
                ( childComponentsList, [], globalData )

        newComMsg =
            Maybe.withDefault
                NullComponentMsg
                (List.head
                    (List.filter
                        (\tmpMsg ->
                            if tmpMsg == NullComponentMsg then
                                False

                            else
                                True
                        )
                        tmpChildComponentsMsg
                    )
                )
    in
    case mainMsg of
        MouseDown ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX - radius, posY - radius ) ( 2 * radius, 2 * radius ) then
                ( model
                    |> dsetbool "show" reverseShowStatus
                    |> dsetLComponent "Child" tmpChildComponentsList
                , if reverseShowStatus == True then
                    ComponentLSStringMsg "OnShow" [ "Settings" ]

                  else
                    ComponentLSStringMsg "OnHide" [ "Settings" ]
                , newGlobalData
                )

            else
                ( model |> dsetLComponent "Child" tmpChildComponentsList, newComMsg, newGlobalData )

        _ ->
            case comMsg of
                ComponentStringMsg demand ->
                    case demand of
                        "Display:HIDE" ->
                            ( model
                                |> dsetbool "show" False
                                |> dsetLComponent "Child" tmpChildComponentsList
                            , newComMsg
                            , newGlobalData
                            )

                        "Display:SHOW" ->
                            ( model
                                |> dsetbool "show" True
                                |> dsetLComponent "Child" tmpChildComponentsList
                            , newComMsg
                            , newGlobalData
                            )

                        _ ->
                            ( model |> dsetLComponent "Child" tmpChildComponentsList, newComMsg, newGlobalData )

                _ ->
                    ( model |> dsetLComponent "Child" tmpChildComponentsList, newComMsg, newGlobalData )


viewSettings : ( Data, Int ) -> GlobalData -> Renderable
viewSettings ( model, _ ) globalData =
    let
        showStatus =
            dgetbool model "show"

        posX =
            dgetint model "posX"

        posY =
            dgetint model "posY"

        radius =
            dgetint model "radius"

        childComponentsList =
            dgetLComponent model "Child"
    in
    group []
        (List.append
            [ shapes [ stroke Color.red ] [ circle (posToReal globalData ( posX, posY )) (widthToReal globalData radius) ]
            , renderText globalData 50 "S" "sans-serif" ( 1633, 20 )
            ]
            (if showStatus then
                List.append [ renderText globalData 50 "Settings" "sans-serif" ( 500, 500 ) ]
                    (List.map (\( comName, comModel ) -> comModel.view ( comModel.data, 0 ) globalData) childComponentsList)

             else
                []
            )
        )
