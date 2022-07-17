module Components.Menu.Map.Map exposing (..)

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


initMap : Int -> ComponentTMsg -> Data
initMap _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "posX", CDInt 900 )
        , ( "posY", CDInt 400 )
        , ( "radius", CDInt 30 )
        , ( "Data", CDDict Dict.empty )
        ]


updateMap : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMap mainMsg comMsg globalData ( model, t ) =
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

                ComponentDictMsg dict ->
                    ( model |> dsetDict "Data" dict, NullComponentMsg, globalData )

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
            , renderText globalData 50 "M" "sans-serif" ( posX - 20, posY - 30 )
            ]
            (if showStatus then
                let
                    data =
                        dgetDict model "Data"

                    charPosX =
                        dgetfloat data "CharPositionX"

                    charPosY =
                        dgetfloat data "CharPositionY"

                    mapWidth =
                        dgetfloat data "MapWidth"

                    mapHeight =
                        dgetfloat data "MapHeight"
                in
                [ renderText globalData 30 "Map" "sans-serif" ( 500, 500 )
                , renderSprite globalData [] ( 500, 550 ) ( 400, 200 ) "background"
                , shapes []
                    (case ( floor mapWidth, floor mapHeight ) of
                        ( 0, _ ) ->
                            []

                        ( _, 0 ) ->
                            []

                        _ ->
                            [ Canvas.circle (posToReal globalData ( floor (500 + charPosX / mapWidth * 400), floor (550 + charPosY / mapHeight * 200) )) (widthToReal globalData 5) ]
                    )
                ]

             else
                []
            )
        )
