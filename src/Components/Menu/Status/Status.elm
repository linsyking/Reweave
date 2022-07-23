module Components.Menu.Status.Status exposing
    ( initStatus
    , updateStatus
    , viewStatus
    )

{-| This is the doc for this module

@docs initStatus

@docs updateStatus

@docs viewStatus

-}

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Components.Menu.Status.Collect.Export as StatusCollectE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetLString, dgetbool, dgetint, dsetDict, dsetbool)
import Lib.Render.Render exposing (..)


{-| initStatus
-}
initStatus : Int -> ComponentTMsg -> Data
initStatus _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "posX", CDInt 750 )
        , ( "posY", CDInt 380 )
        , ( "radius", CDInt 60 )
        , ( "Data", CDDict Dict.empty )
        , ( "Child"
          , CDLComponent
                [ ( "fish"
                  , StatusCollectE.initComponent 0
                        (ComponentStringDictMsg "fish"
                            (Dict.fromList [ ( "posX", CDInt 740 ), ( "posY", CDInt 450 ) ])
                        )
                  )
                , ( "turtle"
                  , StatusCollectE.initComponent 0
                        (ComponentStringDictMsg "turtle"
                            (Dict.fromList [ ( "posX", CDInt 840 ), ( "posY", CDInt 550 ) ])
                        )
                  )
                , ( "bird"
                  , StatusCollectE.initComponent 0
                        (ComponentStringDictMsg "bird"
                            (Dict.fromList [ ( "posX", CDInt 640 ), ( "posY", CDInt 550 ) ])
                        )
                  )
                , ( "fox"
                  , StatusCollectE.initComponent 0
                        (ComponentStringDictMsg "fox"
                            (Dict.fromList [ ( "posX", CDInt 740 ), ( "posY", CDInt 550 ) ])
                        )
                  )
                , ( "lion"
                  , StatusCollectE.initComponent 0
                        (ComponentStringDictMsg "lion"
                            (Dict.fromList [ ( "posX", CDInt 740 ), ( "posY", CDInt 650 ) ])
                        )
                  )
                ]
          )
        ]


{-| updateStatus
-}
updateStatus : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateStatus mainMsg comMsg globalData ( model, t ) =
    let
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
    in
    case mainMsg of
        MouseDown 0 ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX, posY ) ( radius, radius ) then
                ( model
                    |> dsetbool "show" True
                , [ if reverseShowStatus == True then
                        ComponentLSStringMsg "OnShow" [ "Status" ]

                    else
                        ComponentLSStringMsg "OnHide" [ "Status" ]
                  ]
                , globalData
                )

            else
                ( model, [], globalData )

        _ ->
            case comMsg of
                ComponentStringMsg demand ->
                    case demand of
                        "Display:HIDE" ->
                            ( model
                                |> dsetbool "show" False
                            , []
                            , globalData
                            )

                        "Display:SHOW" ->
                            ( model
                                |> dsetbool "show" True
                            , []
                            , globalData
                            )

                        _ ->
                            ( model, [], globalData )

                ComponentStringDictMsg _ dict ->
                    let
                        collectList =
                            dgetLString dict "collectedMonsters"
                    in
                    ( model |> dsetDict "Data" dict, [], globalData )

                _ ->
                    ( model, [], globalData )


{-| viewStatus
-}
viewStatus : ( Data, Int ) -> GlobalData -> Renderable
viewStatus ( model, t ) globalData =
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
                "ot/status"
            ]
            (if showStatus then
                List.append (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
                    [ shapes [ stroke Color.black ] [ circle (posToReal globalData ( 780, 590 )) (widthToReal globalData 150) ] ]

             else
                []
            )
        )
