module Components.Menu.Settings.Settings exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Components.Menu.Settings.Audio.Export as MenuSetAudioE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetbool, dgetint, dsetLComponent, dsetbool)
import Lib.Render.Render exposing (..)


initSettings : Int -> ComponentTMsg -> Data
initSettings _ _ =
    Dict.fromList
        [ ( "show", CDBool True )
        , ( "posX", CDInt 580 )
        , ( "posY", CDInt 380 )
        , ( "radius", CDInt 60 )
        , ( "Child"
          , CDLComponent
                [ ( "AudioDown", MenuSetAudioE.initComponent 0 (ComponentStringMsg "AudioDown") )
                , ( "AudioUp", MenuSetAudioE.initComponent 0 (ComponentStringMsg "AudioUp") )
                ]
          )
        ]


updateSettings : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
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
                        (List.concat tmpChildComponentsMsg)
                    )
                )
    in
    case mainMsg of
        MouseDown 0 ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX, posY ) ( radius, radius ) then
                ( model
                    |> dsetbool "show" True
                    |> dsetLComponent "Child" tmpChildComponentsList
                , [ if reverseShowStatus == True then
                        ComponentLSStringMsg "OnShow" [ "Settings" ]

                    else
                        ComponentLSStringMsg "OnHide" [ "Settings" ]
                  ]
                , newGlobalData
                )

            else
                ( model |> dsetLComponent "Child" tmpChildComponentsList, [ newComMsg ], newGlobalData )

        _ ->
            case comMsg of
                ComponentStringMsg demand ->
                    case demand of
                        "Display:HIDE" ->
                            ( model
                                |> dsetbool "show" False
                                |> dsetLComponent "Child" tmpChildComponentsList
                            , [ newComMsg ]
                            , newGlobalData
                            )

                        "Display:SHOW" ->
                            ( model
                                |> dsetbool "show" True
                                |> dsetLComponent "Child" tmpChildComponentsList
                            , [ newComMsg ]
                            , newGlobalData
                            )

                        _ ->
                            ( model |> dsetLComponent "Child" tmpChildComponentsList, [ newComMsg ], newGlobalData )

                _ ->
                    ( model |> dsetLComponent "Child" tmpChildComponentsList, [ newComMsg ], newGlobalData )


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
            [ renderSprite globalData
                [ if showStatus then
                    alpha 1

                  else
                    alpha 0.3
                ]
                ( posX, posY )
                ( radius, radius )
                "ot/setting"
            ]
            (if showStatus then
                List.append [ renderText globalData 30 ("Current Volume: " ++ (String.fromInt (floor (globalData.audioVolume * 100)) ++ "/100")) "sans-serif" ( 550, 677 ) ]
                    (List.map (\( _, comModel ) -> comModel.view ( comModel.data, 0 ) globalData) childComponentsList)

             else
                []
            )
        )
