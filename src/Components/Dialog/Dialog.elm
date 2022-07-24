module Components.Dialog.Dialog exposing
    ( initDialog
    , checkStatusReport
    , updateDialog
    , viewDialog
    )

{-| This is the doc for this module

@docs initDialog

@docs checkStatusReport

@docs updateDialog

@docs viewDialog

-}

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Components.Dialog.NextButton.Export as DialNextButtonE
import Components.Dialog.Text.Export as DialTextE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetString, dgetint, dsetLComponent, dsetint, dsetstring)
import Lib.Render.Render exposing (renderSprite)



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild) -> OnEnd


{-| initDialog
-}
initDialog : Int -> ComponentTMsg -> Data
initDialog _ comMsg =
    case comMsg of
        ComponentStringDictMsg _ dict ->
            dict
                |> dsetstring "_Status" "OnBuild"
                |> dsetint "_Timer" 0
                |> dsetint "_Index" 0
                |> dsetLComponent "_Child" []

        _ ->
            Dict.empty


{-| checkStatusReport
-}
checkStatusReport : List String -> List ( String, Component ) -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
checkStatusReport list childComponentsList globalData ( model, t ) =
    let
        statusReport =
            Maybe.withDefault "" (List.head list)

        timer =
            dgetint model "_Timer" + 1
    in
    case statusReport of
        "OnBuild" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" childComponentsList
            , []
            , globalData
            )

        "OnShow" ->
            let
                tmpList =
                    List.filter (\( comName, _ ) -> comName == "NextButton") childComponentsList
            in
            if List.isEmpty tmpList then
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetLComponent "_Child"
                        (List.append childComponentsList
                            [ ( "NextButton", DialNextButtonE.initComponent 0 (ComponentStringMsg "") ) ]
                        )
                , []
                , globalData
                )

            else
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetLComponent "_Child" childComponentsList
                , []
                , globalData
                )

        "OnDeBuild" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" childComponentsList
            , []
            , globalData
            )

        "OnEnd" ->
            let
                newChildComponentsList =
                    List.filter
                        (\( comName, _ ) ->
                            if comName == "Text" || comName == "NextButton" then
                                False

                            else
                                True
                        )
                        childComponentsList

                index =
                    dgetint model "_Index" + 1

                spritename =
                    dgetString model (String.fromInt index ++ "CharSprite")
            in
            if dgetint model (String.fromInt index ++ "textExist") == 100 then
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetint "_Index" index
                    |> dsetLComponent "_Child"
                        (List.append newChildComponentsList
                            [ ( "Text", DialTextE.initComponent 0 (ComponentLStringMsg [ dgetString model (String.fromInt index ++ "Text"), spritename ]) ) ]
                        )
                , []
                , globalData
                )

            else
                ( model
                    |> dsetint "_Timer" 0
                    |> dsetint "_Index" index
                    |> dsetstring "_Status" "OnDeBuild"
                    |> dsetLComponent "_Child" newChildComponentsList
                , []
                , globalData
                )

        _ ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" childComponentsList
            , []
            , globalData
            )


{-| updateDialog
-}
updateDialog : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateDialog mainMsg comMsg globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1

                status =
                    dgetString model "_Status"

                spritename =
                    dgetString model (String.fromInt index ++ "CharSprite")

                index =
                    dgetint model "_Index"
            in
            case ( status, timer ) of
                ( "OnBuild", 10 ) ->
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnShow"
                        |> dsetLComponent "_Child" [ ( "Text", DialTextE.initComponent 0 (ComponentLStringMsg [ dgetString model (String.fromInt index ++ "Text"), spritename ]) ) ]
                    , []
                    , globalData
                    )

                ( "OnBuild", _ ) ->
                    ( model |> dsetint "_Timer" timer, [], globalData )

                ( "OnShow", _ ) ->
                    let
                        childComponentsList =
                            dgetLComponent model "_Child"

                        ( newChildComponentsList, newChildComponentMsg ) =
                            List.foldl
                                (\( comName, comModel ) ( tmpComponentsList, tmpComponentsMsg ) ->
                                    if comName == "Text" then
                                        let
                                            ( tmpData, tmpMsg, _ ) =
                                                comModel.update mainMsg NullComponentMsg globalData ( comModel.data, t )
                                        in
                                        ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], tmpComponentsMsg ++ tmpMsg )

                                    else
                                        let
                                            ( tmpData, _, _ ) =
                                                comModel.update mainMsg NullComponentMsg globalData ( comModel.data, t )
                                        in
                                        ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], tmpComponentsMsg )
                                )
                                ( [], [] )
                                childComponentsList
                    in
                    case List.head newChildComponentMsg of
                        Just (ComponentLSStringMsg demand list) ->
                            case demand of
                                "StatusReport" ->
                                    checkStatusReport list newChildComponentsList globalData ( model, t )

                                _ ->
                                    ( model
                                        |> dsetint "_Timer" timer
                                        |> dsetLComponent "_Child" newChildComponentsList
                                    , []
                                    , globalData
                                    )

                        _ ->
                            ( model
                                |> dsetint "_Timer" timer
                                |> dsetLComponent "_Child" newChildComponentsList
                            , []
                            , globalData
                            )

                ( "OnDeBuild", 10 ) ->
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnEnd"
                    , [ ComponentStringMsg "skip" ]
                    , globalData
                    )

                ( "OnDeBuild", _ ) ->
                    ( model
                        |> dsetint "_Timer" timer
                    , []
                    , globalData
                    )

                ( "OnEnd", _ ) ->
                    ( model
                    , [ ComponentStringMsg "OnEnd" ]
                    , globalData
                    )

                ( _, _ ) ->
                    ( model |> dsetint "_Timer" timer, [], globalData )

        MouseDown _ ( x, y ) ->
            if judgeMouse globalData ( x, y ) ( 1649, 90 ) ( 40, 40 ) then
                ( model
                    |> dsetint "_Timer" 0
                    |> dsetstring "_Status" "OnDeBuild"
                    |> dsetLComponent "_Child" []
                , []
                , globalData
                )

            else
                let
                    childComponetsList =
                        dgetLComponent model "_Child"

                    ( newChildComponentsList, newChildComponentMsg ) =
                        List.foldl
                            (\( comName, comModel ) ( tmpComponentsList, tmpComponentsMsg ) ->
                                if comName == "NextButton" then
                                    let
                                        ( tmpData, tmpMsg, _ ) =
                                            comModel.update (KeyDown 13) NullComponentMsg globalData ( comModel.data, t )
                                    in
                                    ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], tmpMsg )

                                else
                                    ( List.append tmpComponentsList [ ( comName, comModel ) ], tmpComponentsMsg )
                            )
                            ( [], [] )
                            childComponetsList
                in
                case List.head newChildComponentMsg of
                    Just (ComponentLSStringMsg demand list) ->
                        case demand of
                            "Interaction" ->
                                let
                                    request =
                                        Maybe.withDefault "" (List.head list)
                                in
                                if request == "OnDeBuild" then
                                    let
                                        ( tmpChildComponentsList, _ ) =
                                            List.foldl
                                                (\( comName, comModel ) ( tmpComponentsList, tmpComponentsMsg ) ->
                                                    if comName == "Text" then
                                                        let
                                                            ( tmpData, tmpMsg, _ ) =
                                                                comModel.update UnknownMsg (ComponentStringMsg "OnDeBuild") globalData ( comModel.data, t )
                                                        in
                                                        ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], tmpMsg )

                                                    else
                                                        ( List.append tmpComponentsList [ ( comName, comModel ) ], tmpComponentsMsg )
                                                )
                                                ( [], [] )
                                                childComponetsList
                                    in
                                    ( model |> dsetLComponent "_Child" tmpChildComponentsList, [], globalData )

                                else
                                    ( model |> dsetLComponent "_Child" newChildComponentsList, [], globalData )

                            _ ->
                                ( model |> dsetLComponent "_Child" newChildComponentsList, [], globalData )

                    _ ->
                        ( model |> dsetLComponent "_Child" newChildComponentsList, [], globalData )

        _ ->
            case comMsg of
                ComponentStringMsg str ->
                    if str == "Close" then
                        ( model
                            |> dsetint "_Timer" 0
                            |> dsetstring "_Status" "OnDeBuild"
                            |> dsetLComponent "_Child" []
                        , []
                        , globalData
                        )

                    else
                        ( model, [], globalData )

                _ ->
                    ( model, [], globalData )


{-| viewDialog
-}
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
    case status of
        "OnBuild" ->
            group []
                (List.append
                    (if timer == 0 then
                        []

                     else
                        [ renderSprite globalData [] ( 859 - 72 * timer, 50 ) ( 154 * timer, 300 ) "dialogue"
                        ]
                    )
                    (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
                )

        "OnDeBuild" ->
            group []
                (List.append
                    [ renderSprite globalData [] ( 189 + 72 * timer, 50 ) ( 1540 - 154 * timer, 300 ) "dialogue"
                    ]
                    (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
                )

        "OnEnd" ->
            group [] []

        _ ->
            group []
                (List.append
                    [ renderSprite globalData [] ( 189, 50 ) ( 1540, 300 ) "dialogue"
                    , renderSprite globalData [] ( 1649, 90 ) ( 40, 40 ) "ot/close"
                    ]
                    (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
                )
