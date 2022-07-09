module Components.Menu.Settings.Settings exposing (..)

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


initSettings : Int -> ComponentTMsg -> Data
initSettings _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "posX", CDInt 1650 )
        , ( "posY", CDInt 50 )
        , ( "radius", CDInt 30 )
        ]


updateSettings : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateSettings mainMsg _ globalData ( model, t ) =
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
        MouseDown ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( posX - radius, posY - radius ) ( 2 * radius, 2 * radius ) then
                ( model
                    |> dsetbool "show" reverseShowStatus
                , NullComponentMsg
                , globalData
                )

            else
                ( model, NullComponentMsg, globalData )

        _ ->
            ( model, NullComponentMsg, globalData )


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
    in
    group []
        (List.append
            [ shapes [ stroke Color.red ] [ circle (posToReal globalData ( posX, posY )) (widthToReal globalData radius) ]
            , renderText globalData 50 "S" "sans-serif" ( 1633, 20 )
            ]
            (if showStatus then
                [ renderText globalData 50 "Settings" "sans-serif" ( 500, 500 ) ]

             else
                []
            )
        )
