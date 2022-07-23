module Components.Menu.Status.Collect.Collect exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
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
        ComponentStringDictMsg str dict ->
            Dict.fromList
                [ ( "show", CDBool True )
                , ( "posX", CDInt (dgetint dict "posX") )
                , ( "posY", CDInt (dgetint dict "posY") )
                , ( "MonsterSprite", CDString str )
                , ( "Collected", CDBool False )
                , ( "Width", CDInt 50 )
                , ( "Height", CDInt 50 )
                ]

        _ ->
            Dict.empty


{-| updateMap
-}
updateMap : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateMap _ comMsg globalData ( model, t ) =
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
    in
    group []
        [ renderSprite globalData [] ( posX, posY ) ( 80, 80 ) (dgetString model "MonsterSprite")
        , shapes [ stroke Color.black ] [ rect (posToReal globalData ( posX, posY )) (widthToReal globalData 80) (heightToReal globalData 80) ]
        ]
