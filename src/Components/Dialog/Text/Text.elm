module Components.Dialog.Text.Text exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetDict, dgetLComponent, dgetString, dgetbool, dgetint, dsetLComponent, dsetbool, dsetint, dsetstring)
import Lib.Render.Render exposing (renderText)



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild)


initText : Int -> ComponentTMsg -> Data
initText _ comMsg =
    case comMsg of
        ComponentDictMsg dict ->
            dict
                |> dsetstring "_Status" "OnBuild"
                |> dsetint "_Timer" 0
                |> dsetLComponent "_Child" []

        _ ->
            Dict.empty


updateText : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateText mainMsg comMsg globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1
            in
            if timer > 10 then
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetstring "_Status" "Onshow"
                , NullComponentMsg
                , globalData
                )

            else
                ( model |> dsetint "_Timer" timer, NullComponentMsg, globalData )

        _ ->
            ( model, NullComponentMsg, globalData )


viewText : ( Data, Int ) -> GlobalData -> Renderable
viewText ( model, t ) globalData =
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
                    [ rect (posToReal globalData ( 400, 300 )) (widthToReal globalData 800) (heightToReal globalData (50 * timer))
                    ]
                ]
                (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
            )

    else
        group []
            (List.append
                [ shapes [ stroke Color.black ]
                    [ rect (posToReal globalData ( 400, 300 )) (widthToReal globalData 800) (heightToReal globalData 500)
                    ]
                ]
                (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
            )
