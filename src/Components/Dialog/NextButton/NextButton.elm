module Components.Dialog.NextButton.NextButton exposing
    ( initButton
    , updateButton
    , viewButton
    )

{-| This is the doc for this module

@docs initButton

@docs updateButton

@docs viewButton

-}

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetint, dsetstring)
import Lib.Render.Render exposing (renderSprite)



-- OnBuild -> OnShow -> OnDeBuild -> OnEnd
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild) -> OnEnd


{-| initButton
-}
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


{-| updateButton
-}
updateButton : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateButton mainMsg _ globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1
            in
            ( model
                |> dsetint "_Timer" timer
            , [ ComponentLSStringMsg "StatusReport" [ "OnShow" ] ]
            , globalData
            )

        KeyDown 13 ->
            ( model
                |> dsetstring "_Status" "OnEnd"
            , [ ComponentLSStringMsg "Interaction" [ "OnDeBuild" ] ]
            , globalData
            )

        _ ->
            let
                status =
                    dgetString model "_Status"
            in
            ( model, [ ComponentLSStringMsg "StatusReport" [ status ] ], globalData )


{-| viewButton
-}
viewButton : ( Data, Int ) -> GlobalData -> Renderable
viewButton ( model, t ) globalData =
    if dgetString model "_Status" == "OnShow" then
        -- group []
        -- [ shapes
        --     [ fill Color.blue ]
        --     -- [ rect (posToReal globalData ( 1350, 320 )) (widthToReal globalData 10) (heightToReal globalData 10) ]
        -- ]
        renderSprite globalData
            []
            ( 1600
            , 280
                + (if modBy 30 t <= 15 then
                    2

                   else
                    -2
                  )
            )
            ( 20, 13 )
            "downbutton"

    else
        group [] []
