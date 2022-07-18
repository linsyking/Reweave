module Components.Dialog.Dialog exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Components.Dialog.Text.Export as DialTextE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetDict, dgetLComponent, dgetString, dgetbool, dgetint, dsetLComponent, dsetbool, dsetint, dsetstring)
import Lib.Render.Render exposing (renderText)



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild) -> OnEnd


initDialog : Int -> ComponentTMsg -> Data
initDialog _ comMsg =
    case comMsg of
        ComponentDictMsg dict ->
            dict
                |> dsetstring "_Status" "OnBuild"
                |> dsetint "_Timer" 0
                |> dsetint "_Index" 0
                |> dsetLComponent "_Child" []

        _ ->
            Dict.empty


checkStatusReport : List String -> List ( String, Component ) -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
checkStatusReport list newChildComponentsList globalData ( model, t ) =
    let
        statusReport =
            Maybe.withDefault "" (List.head list)

        timer =
            dgetint model "_Timer" + 1

        status =
            dgetString model "_Status"
    in
    case statusReport of
        "OnBuild" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" newChildComponentsList
            , NullComponentMsg
            , globalData
            )

        "OnShow" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" newChildComponentsList
            , NullComponentMsg
            , globalData
            )

        "OnDeBuild" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" newChildComponentsList
            , NullComponentMsg
            , globalData
            )

        "OnEnd" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" newChildComponentsList
            , NullComponentMsg
            , globalData
            )

        _ ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" newChildComponentsList
            , NullComponentMsg
            , globalData
            )


updateDialog : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateDialog mainMsg comMsg globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1

                status =
                    dgetString model "_Status"
            in
            case ( status, timer ) of
                ( "OnBuild", 10 ) ->
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnShow"
                        |> dsetLComponent "_Child" [ ( "Text", DialTextE.initComponent 0 NullComponentMsg ) ]
                    , NullComponentMsg
                    , globalData
                    )

                ( "OnBuild", _ ) ->
                    ( model |> dsetint "_Timer" timer, NullComponentMsg, globalData )

                ( "OnShow", _ ) ->
                    let
                        childComponetsList =
                            dgetLComponent model "_Child"

                        ( newChildComponentsList, newChildComponentMsg ) =
                            List.foldl
                                (\( comName, comModel ) ( tmpComponentsList, tmpComponentsMsg ) ->
                                    if comName == "Text" then
                                        let
                                            ( tmpData, tmpMsg, _ ) =
                                                comModel.update mainMsg NullComponentMsg globalData ( comModel.data, t )
                                        in
                                        ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], tmpMsg )

                                    else
                                        ( List.append tmpComponentsList [ ( comName, comModel ) ], tmpComponentsMsg )
                                )
                                ( [], NullComponentMsg )
                                childComponetsList
                    in
                    case newChildComponentMsg of
                        ComponentLSStringMsg demand list ->
                            case demand of
                                "StatusReport" ->
                                    checkStatusReport list newChildComponentsList globalData ( model, t )

                                _ ->
                                    ( model
                                        |> dsetint "_Timer" timer
                                        |> dsetLComponent "_Child" newChildComponentsList
                                    , NullComponentMsg
                                    , globalData
                                    )

                        _ ->
                            ( model
                                |> dsetint "_Timer" timer
                                |> dsetLComponent "_Child" newChildComponentsList
                            , NullComponentMsg
                            , globalData
                            )

                ( _, _ ) ->
                    ( model |> dsetint "_Timer" timer, NullComponentMsg, globalData )

        _ ->
            ( model, NullComponentMsg, globalData )


viewDialog : ( Data, Int ) -> GlobalData -> Renderable
viewDialog ( model, t ) globalData =
    let
        status =
            dgetString model "_Status"

        timer =
            dgetint model "_Timer"

        childComponentsList =
            dgetLComponent model "_Child"
    in
    if status == "OnBuild" then
        group []
            (List.append
                [ shapes [ stroke Color.black ]
                    [ rect (posToReal globalData ( 600, 200 - 15 * timer )) (widthToReal globalData 800) (heightToReal globalData (30 * timer))
                    ]
                ]
                (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
            )

    else
        group []
            (List.append
                [ shapes [ stroke Color.black ]
                    [ rect (posToReal globalData ( 600, 50 )) (widthToReal globalData 800) (heightToReal globalData 300)
                    ]
                ]
                (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
            )
