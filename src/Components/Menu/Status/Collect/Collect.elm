module Components.Menu.Status.Collect.Collect exposing
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
import Color
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

                "Collected" ->
                    ( model
                        |> dsetbool "Collected" True
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

        collected =
            dgetbool model "Collected"
    in
    group []
        (if collected then
            [ renderSprite globalData [] ( posX, posY ) ( 80, 80 ) (dgetString model "MonsterSprite")
            , shapes [ stroke Color.black ] [ rect (posToReal globalData ( posX, posY )) (widthToReal globalData 80) (heightToReal globalData 80) ]
            ]

         else
            [ shapes [ stroke Color.black ] [ rect (posToReal globalData ( posX, posY )) (widthToReal globalData 80) (heightToReal globalData 80) ]
            ]
        )
