module Components.Menu.Map.Map exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict exposing (Dict)
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..), dgetbool, dgetfloat, dgetint, dsetbool)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (..)


initMap : Int -> ComponentTMsg -> Data
initMap _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "posX", CDInt 1870 )
        , ( "posY", CDInt 280 )
        , ( "radius", CDInt 30 )
        ]


updateMap : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMap mainMsg comMsg globalData ( model, t ) =
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
    in
    case mainMsg of
        MouseDown ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX - radius, posY - radius ) ( 2 * radius, 2 * radius ) then
                ( model
                    |> dsetbool "show" reverseShowStatus
                , if reverseShowStatus == True then
                    ComponentLSStringMsg "OnShow" [ "Map" ]

                  else
                    ComponentLSStringMsg "OnHide" [ "Map" ]
                , globalData
                )

            else
                ( model, NullComponentMsg, globalData )

        _ ->
            case comMsg of
                ComponentStringMsg demand ->
                    case demand of
                        "Display:HIDE" ->
                            ( model
                                |> dsetbool "show" False
                            , NullComponentMsg
                            , globalData
                            )

                        "Display:SHOW" ->
                            ( model
                                |> dsetbool "show" True
                            , NullComponentMsg
                            , globalData
                            )

                        _ ->
                            ( model, NullComponentMsg, globalData )

                _ ->
                    ( model, NullComponentMsg, globalData )


viewMap : ( Data, Int ) -> GlobalData -> Renderable
viewMap ( model, _ ) globalData =
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
            [ shapes [ stroke Color.red ] [ circle (posToReal globalData ( posX, posY )) (widthToReal globalData radius) ]
            , renderText globalData 50 "M" "sans-serif" ( 1850, 250 )
            ]
            (if showStatus then
                [ renderText globalData 50 "Map" "sans-serif" ( 500, 500 ) ]

             else
                []
            )
        )
