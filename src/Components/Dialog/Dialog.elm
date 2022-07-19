module Components.Dialog.Dialog exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Components.Dialog.NextButton.Export as DialNextButtonE
import Components.Dialog.Text.Export as DialTextE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetString, dgetint, dsetLComponent, dsetint, dsetstring)



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
            , NullComponentMsg
            , globalData
            )

        "OnShow" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child"
                    (List.append childComponentsList
                        [ ( "NextButton", DialNextButtonE.initComponent 0 (ComponentStringMsg "") ) ]
                    )
            , NullComponentMsg
            , globalData
            )

        "OnDeBuild" ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" childComponentsList
            , NullComponentMsg
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
            in
            if dgetint model (String.fromInt index ++ "textExist") == 100 then
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetint "_Index" index
                    |> dsetLComponent "_Child"
                        (List.append newChildComponentsList
                            [ ( "Text", DialTextE.initComponent 0 (ComponentStringMsg (dgetString model (String.fromInt index ++ "Text"))) ) ]
                        )
                , NullComponentMsg
                , globalData
                )

            else
                ( model
                    |> dsetint "_Timer" 0
                    |> dsetint "_Index" index
                    |> dsetstring "_Status" "OnDeBuild"
                    |> dsetLComponent "_Child" newChildComponentsList
                , NullComponentMsg
                , globalData
                )

        _ ->
            ( model
                |> dsetint "_Timer" timer
                |> dsetLComponent "_Child" childComponentsList
            , NullComponentMsg
            , globalData
            )
