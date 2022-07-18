module Components.Dialog.NextButton.NextButton exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetint, dsetstring)



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild)


initButton : Int -> ComponentTMsg -> Data
initButton _ comMsg =
    case comMsg of
        ComponentStringMsg _ ->
            Dict.fromList
                [ ( "_Status", CDString "OnShow" )
                , ( "_Timer", CDInt 0 )
                , ( "_Child", CDLComponent [] )
                ]

        _ ->
            Dict.empty


updateButton : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateButton mainMsg _ globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1
            in
            ( model
                |> dsetint "_Timer" timer
            , ComponentLSStringMsg "StatusReport" [ "OnShow" ]
            , globalData
            )

        KeyDown 13 ->
            ( model
                |> dsetstring "_Status" "OnEnd"
            , ComponentLSStringMsg "Interaction" [ "OnDeBuild" ]
            , globalData
            )

        _ ->
            let
                status =
                    dgetString model "_Status"
            in
            ( model, ComponentLSStringMsg "StatusReport" [ status ], globalData )


viewButton : ( Data, Int ) -> GlobalData -> Renderable
viewButton ( model, t ) globalData =
    if dgetString model "_Status" == "OnShow" then
        group []
            [ shapes
                [ fill Color.blue ]
                [ rect (posToReal globalData ( 400, 300 )) (widthToReal globalData 800) (heightToReal globalData 500) ]
            ]

    else
        group [] []
