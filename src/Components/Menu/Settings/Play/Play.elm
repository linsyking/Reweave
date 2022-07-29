module Components.Menu.Settings.Play.Play exposing
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
import Lib.DefinedTypes.Parser exposing (dgetString, dgetbool, dgetint, dsetbool)
import Lib.Render.Render exposing (..)


{-| initMap
-}
initMap : Int -> ComponentTMsg -> Data
initMap _ comMsg =
    case comMsg of
        ComponentStringMsg demand ->
            case demand of
                "Continue" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 560 )
                        , ( "posY", CDInt 500 )
                        , ( "Type", CDString "continue" )
                        , ( "Text", CDString "Continue" )
                        , ( "Width", CDInt 160 )
                        , ( "Height", CDInt 50 )
                        ]

                "Restart" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 560 )
                        , ( "posY", CDInt 550 )
                        , ( "Type", CDString "restart" )
                        , ( "Text", CDString "Restart" )
                        , ( "Width", CDInt 140 )
                        , ( "Height", CDInt 50 )
                        ]

                "Skip Cutscene" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 560 )
                        , ( "posY", CDInt 600 )
                        , ( "Type", CDString "skipcutscene" )
                        , ( "Text", CDString "Skip Cutscene" )
                        , ( "Width", CDInt 200 )
                        , ( "Height", CDInt 50 )
                        ]

                "VisualAid" ->
                    Dict.fromList
                        [ ( "show", CDBool True )
                        , ( "posX", CDInt 560 )
                        , ( "posY", CDInt 600 )
                        , ( "Type", CDString "visualaid" )
                        , ( "Width", CDInt 350 )
                        , ( "Height", CDInt 50 )
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

        width =
            dgetint model "Width"

        height =
            dgetint model "Height"

        comType =
            dgetString model "Type"

        status =
            dgetbool model "show"
    in
    case mainMsg of
        MouseDown 0 ( x, y ) ->
            if status then
                if judgeMouse globalData ( x, y ) ( posX, posY ) ( width, height ) then
                    ( model
                    , [ ComponentLStringMsg [ comType ] ]
                    , globalData
                    )

                else
                    ( model, [], globalData )

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

        ctype =
            dgetString model "Type"
    in
    if ctype == "visualaid" then
        let
            turnedon =
                globalData.visualaid
        in
        if turnedon then
            renderText globalData 30 "Turn off Visual Aid" "Courier New" ( posX, posY )

        else
            renderText globalData 30 "Turn on Visual Aid" "Courier New" ( posX, posY )

    else
        renderText globalData 30 (dgetString model "Text") "Courier New" ( posX, posY )
