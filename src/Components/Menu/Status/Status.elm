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
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetDict, dgetbool, dgetfloat, dgetint, dsetDict, dsetbool)
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
                    ( model |> dsetDict "Data" dict, [], globalData )

                _ ->
                    ( model, [], globalData )


{-| viewStatus
-}
viewStatus : ( Data, Int ) -> GlobalData -> Renderable
viewStatus ( model, _ ) globalData =
    let
        showStatus =
            dgetbool model "show"

        posX =
            dgetint model "posX"

        posY =
            dgetint model "posY"

        radius =
            dgetint model "radius"
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
                let
                    data =
                        dgetDict model "Data"

                    charLife =
                        dgetint data "CharLife"

                    charEnergy =
                        dgetfloat data "CharEnergy"
                in
                [ renderText globalData 30 "Status" "sans-serif" ( 500, 500 )
                , renderText globalData 30 ("Life: " ++ String.fromInt charLife) "sans-serif" ( 500, 530 )
                , renderText globalData 30 ("Energy: " ++ String.fromFloat charEnergy) "sans-serif" ( 500, 560 )
                ]

             else
                []
            )
        )
