module Components.Menu.Status.Status exposing (..)

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


initStatus : Int -> ComponentTMsg -> Data
initStatus _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "life", CDInt 10 )
        , ( "kinetic energy", CDInt 0 )
        , ( "posX", CDInt 1000 )
        , ( "posY", CDInt 1000 )
        , ( "radius", CDInt 50 )
        ]


updateStatus : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateStatus mainMsg _ globalData ( model, t ) =
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
        [ shapes [ stroke Color.grey ] [ circle (posToReal globalData ( posX, posY )) (widthToReal globalData radius) ]
        , if showStatus then
            renderText globalData 50 "Show" "sans-serif" ( 500, 500 )

          else
            renderText globalData 50 "Hide" "sans-serif" ( 500, 500 )
        ]
