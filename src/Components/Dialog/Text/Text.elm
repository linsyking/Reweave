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
        ComponentStringMsg str ->
            Dict.fromList
                [ ( "_Status", CDString "OnBuild" )
                , ( "_Timer", CDInt 0 )
                , ( "_wholeText", CDString str )
                , ( "ScreenText", CDString "" )
                , ( "_wholeTextLength", CDInt (String.length str) )
                , ( "_currentPos", CDInt 0 )
                , ( "_Child", CDLComponent [] )
                ]

        _ ->
            Dict.empty


updateText : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateText mainMsg comMsg globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1

                currentPos =
                    dgetint model "_currentPos" + 1

                wholeLength =
                    dgetint model "_wholeTextLength"
            in
            if currentPos > wholeLength then
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetstring "_Status" "OnShow"
                , ComponentLSStringMsg "StatusReport" [ "OnShow" ]
                , globalData
                )

            else
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetint "_currentPos" currentPos
                    |> dsetstring "ScreenText" (String.slice 0 currentPos (dgetString model "_wholeText"))
                , ComponentLSStringMsg "StatusReport" [ "OnBuild" ]
                , globalData
                )

        _ ->
            let
                status =
                    dgetString model "_Status"
            in
            case comMsg of
                ComponentStringMsg demand ->
                    case demand of
                        "OnDeBuild" ->
                            ( model
                                |> dsetstring "_Status" "OnEnd"
                            , ComponentLSStringMsg "StatusReport" [ "OnEnd" ]
                            , globalData
                            )

                        _ ->
                            ( model, ComponentLSStringMsg "StatusReport" [ status ], globalData )

                _ ->
                    ( model, ComponentLSStringMsg "StatusReport" [ status ], globalData )


viewText : ( Data, Int ) -> GlobalData -> Renderable
viewText ( model, t ) globalData =
    group []
        [ renderText globalData 30 (dgetString model "ScreenText") "sans-serif" ( 650, 100 ) ]
