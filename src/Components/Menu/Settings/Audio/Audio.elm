module Components.Menu.Settings.Audio.Audio exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..), dgetString, dgetint, dsetbool)
import Lib.Coordinate.Coordinates exposing (..)
import Lib.Render.Render exposing (..)


initMap : Int -> ComponentTMsg -> Data
initMap _ comMsg =
    case comMsg of
        ComponentStringMsg demand ->
            case demand of
                "AudioDown" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 670 )
                        , ( "posY", CDInt 680 )
                        , ( "Type", CDString "Down" )
                        , ( "radius", CDInt 30 )
                        ]

                "AudioUp" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 750 )
                        , ( "posY", CDInt 680 )
                        , ( "Type", CDString "Up" )
                        , ( "radius", CDInt 30 )
                        ]

                _ ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 670 )
                        , ( "posY", CDInt 680 )
                        , ( "Type", CDString "Unknown" )
                        , ( "radius", CDInt 30 )
                        ]

        _ ->
            Dict.fromList
                [ ( "show", CDBool True )
                , ( "posX", CDInt 670 )
                , ( "posY", CDInt 680 )
                , ( "Type", CDString "Unknown" )
                , ( "radius", CDInt 30 )
                ]


updateMap : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateMap mainMsg comMsg globalData ( model, t ) =
    let
        posX =
            dgetint model "posX"

        posY =
            dgetint model "posY"

        radius =
            dgetint model "radius"

        comType =
            dgetString model "Type"
    in
    case mainMsg of
        MouseDown ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX - radius, posY - radius ) ( 2 * radius, 2 * radius ) then
                ( model
                , NullComponentMsg
                , case comType of
                    "Down" ->
                        { globalData
                            | audioVolume =
                                if globalData.audioVolume >= 0.1 then
                                    globalData.audioVolume - 0.1

                                else
                                    globalData.audioVolume
                        }

                    "Up" ->
                        { globalData
                            | audioVolume =
                                if globalData.audioVolume <= 0.9 then
                                    globalData.audioVolume + 0.1

                                else
                                    globalData.audioVolume
                        }

                    _ ->
                        globalData
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
        posX =
            dgetint model "posX"

        posY =
            dgetint model "posY"

        radius =
            dgetint model "radius"

        comType =
            case dgetString model "Type" of
                "Down" ->
                    "D"

                "Up" ->
                    "U"

                _ ->
                    ""
    in
    group []
        [ shapes [ stroke Color.red ] [ circle (posToReal globalData ( posX, posY )) (widthToReal globalData radius) ]
        , renderText globalData 50 comType "sans-serif" ( posX - 20, posY - 25 )
        ]
