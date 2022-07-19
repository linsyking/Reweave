module Components.Dialog.Text.Word.Word exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetint, dsetstring)
import Lib.Render.Render exposing (renderText)



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild)


initWord : Int -> ComponentTMsg -> Data
initWord pos comMsg =
    case comMsg of
        ComponentStringMsg str ->
            Dict.fromList
                [ ( "_Status", CDString "OnBuild" )
                , ( "_Timer", CDInt 0 )
                , ( "_Position", CDInt pos )
                , ( "Word", CDString str )
                , ( "_Child", CDLComponent [] )
                ]

        _ ->
            Dict.empty


updateWord : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateWord mainMsg comMsg globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1
            in
            if timer > 10 then
                if dgetString model "_Status" == "OnBuild" then
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnShow"
                    , ComponentLSStringMsg "StatusReport" [ "OnShow" ]
                    , globalData
                    )

                else
                    ( model
                        |> dsetint "_Timer" timer
                    , ComponentLSStringMsg "StatusReport" [ dgetString model "_Status" ]
                    , globalData
                    )

            else
                ( model
                    |> dsetint "_Timer" timer
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


viewWord : ( Data, Int ) -> GlobalData -> Renderable
viewWord ( model, t ) globalData =
    let
        position =
            dgetint model "_Position"
    in
    group []
        [ renderText globalData 30 (dgetString model "Word") "sans-serif" ( 650 + position, 100 ) ]
