module Components.Menu.Settings.Audio.Audio exposing
    ( initMap
    , updateMap
    , viewMap
    )

{-| This is the doc for this module

@docs initMap

@docs updateMap

@docs viewMap

-}

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetbool)
import Lib.Render.Render exposing (..)


{-| initMap
-}
initMap : Int -> ComponentTMsg -> Data
initMap _ comMsg =
    case comMsg of
        ComponentStringMsg demand ->
            case demand of
                "AudioDown" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 910 )
                        , ( "posY", CDInt 680 )
                        , ( "Type", CDString "Down" )
                        , ( "radius", CDInt 30 )
                        ]

                "AudioUp" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 1000 )
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


{-| updateMap
-}
updateMap : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
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
        MouseDown 0 ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX, posY ) ( radius, radius ) then
                let
                    oldlo =
                        globalData.localstorage
                in
                ( model
                , []
                , case comType of
                    "Down" ->
                        let
                            newaudiov =
                                if globalData.audioVolume >= 0.1 then
                                    globalData.audioVolume - 0.1

                                else
                                    globalData.audioVolume
                        in
                        { globalData
                            | audioVolume = newaudiov
                            , localstorage = { oldlo | volume = newaudiov * 100 }
                        }

                    "Up" ->
                        let
                            newaudiov =
                                if globalData.audioVolume <= 0.9 then
                                    globalData.audioVolume + 0.1

                                else
                                    globalData.audioVolume
                        in
                        { globalData
                            | audioVolume = newaudiov
                            , localstorage = { oldlo | volume = newaudiov * 100 }
                        }

                    _ ->
                        globalData
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

                _ ->
                    ( model, [], globalData )


{-| viewMap
-}
viewMap : ( Data, Int ) -> GlobalData -> Renderable
viewMap ( model, _ ) globalData =
    let
        posX =
            dgetint model "posX"

        posY =
            dgetint model "posY"

        radius =
            dgetint model "radius"
    in
    case dgetString model "Type" of
        "Down" ->
            renderSprite globalData [] ( posX, posY ) ( radius, radius ) "ot/vdown"

        "Up" ->
            renderSprite globalData [] ( posX, posY ) ( radius, radius ) "ot/vup"

        _ ->
            group [] []
