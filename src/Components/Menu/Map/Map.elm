module Components.Menu.Map.Map exposing
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
import Lib.DefinedTypes.Parser exposing (dgetDict, dgetString, dgetbool, dgetint, dsetDict, dsetbool)
import Lib.Render.Render exposing (..)


{-| initMap
-}
initMap : Int -> ComponentTMsg -> Data
initMap _ _ =
    Dict.fromList
        [ ( "show", CDBool False )
        , ( "posX", CDInt 900 )
        , ( "posY", CDInt 380 )
        , ( "radius", CDInt 60 )
        , ( "Data", CDDict Dict.empty )
        ]


{-| updateMap
-}
updateMap : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
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
            if judgeMouse globalData ( x, y ) ( posX, posY ) ( radius, radius ) then
                ( model
                    |> dsetbool "show" True
                , [ if reverseShowStatus == True then
                        ComponentLSStringMsg "OnShow" [ "Map" ]

                    else
                        ComponentLSStringMsg "OnHide" [ "Map" ]
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


{-| viewMap
-}
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
            [ renderSprite globalData
                [ if showStatus then
                    alpha 1

                  else
                    alpha 0.3
                ]
                ( posX, posY )
                ( radius, radius )
                "ot/map"
            ]
            (if showStatus then
                let
                    data =
                        dgetDict model "Data"

                    map =
                        dgetString data "bgimg"

                    -- charPosX =
                    --     dgetfloat data "CharPositionX"
                    -- charPosY =
                    --     dgetfloat data "CharPositionY"
                    -- mapWidth =
                    --     dgetfloat data "MapWidth"
                    -- mapHeight =
                    --     dgetfloat data "MapHeight"
                in
                [ renderSprite globalData [] ( 550, 480 ) ( 500, 250 ) map ]
                -- , shapes [ fill Color.red ]
                --     (case ( floor mapWidth, floor mapHeight ) of
                --         ( 0, _ ) ->
                --             []
                --         ( _, 0 ) ->
                --             []
                --         _ ->
                --             [ Canvas.circle (posToReal globalData ( floor (550 + charPosX / mapWidth * 500), floor (450 + charPosY / mapHeight * 300) )) (widthToReal globalData 5) ]
                --     )
                -- ]

             else
                []
            )
        )
