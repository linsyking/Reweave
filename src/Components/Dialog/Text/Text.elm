module Components.Dialog.Text.Text exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Components.Dialog.Text.Word.Export as DialTextWordE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetString, dgetint, dsetLComponent, dsetint, dsetstring)



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
                , ( "_currentPos", CDInt -1 )
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

                currentLength =
                    dgetint model "_currentLength" + floor (heightToReal globalData 30)

                childComponentsList =
                    dgetLComponent model "_Child"

                ( newChildComponentsList, allChildComponentsMsg ) =
                    List.foldl
                        (\( comName, comModel ) ( tmpComponentsList, tmpComponentsMsg ) ->
                            let
                                ( tmpData, tmpMsg, _ ) =
                                    comModel.update mainMsg NullComponentMsg globalData ( comModel.data, t )
                            in
                            ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], List.append tmpComponentsMsg [ tmpMsg ] )
                        )
                        ( [], [] )
                        childComponentsList
            in
            if currentPos > wholeLength then
                if dgetString model "_Status" == "OnBuild" then
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnShow"
                        |> dsetLComponent "_Child" newChildComponentsList
                    , ComponentLSStringMsg "StatusReport" [ "OnShow" ]
                    , globalData
                    )

                else if List.all (\x -> x == ComponentLSStringMsg "StatusReport" [ "OnEnd" ]) allChildComponentsMsg then
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnEnd"
                        |> dsetLComponent "_Child" newChildComponentsList
                    , ComponentLSStringMsg "StatusReport" [ "OnEnd" ]
                    , globalData
                    )

                else if dgetString model "_Status" == "OnDeBuild" then
                    let
                        ( tmpChildComponentsList, _, _ ) =
                            List.foldl
                                (\( comName, comModel ) ( tmpComponentsList, tmpAllMsg, tmpFlag ) ->
                                    let
                                        tmpMsg =
                                            Maybe.withDefault NullComponentMsg (List.head tmpAllMsg)
                                    in
                                    let
                                        ( tmpData, _, _ ) =
                                            if tmpMsg == ComponentLSStringMsg "StatusReport" [ "OnShow" ] && tmpFlag == True then
                                                comModel.update UnknownMsg (ComponentStringMsg "OnDeBuild") globalData ( comModel.data, t )

                                            else
                                                comModel.update mainMsg NullComponentMsg globalData ( comModel.data, t )
                                    in
                                    if tmpMsg == ComponentLSStringMsg "StatusReport" [ "OnShow" ] && tmpFlag == True then
                                        ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], List.drop 1 tmpAllMsg, False )

                                    else
                                        ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], List.drop 1 tmpAllMsg, tmpFlag )
                                )
                                ( [], allChildComponentsMsg, True )
                                childComponentsList
                    in
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetLComponent "_Child" tmpChildComponentsList
                    , ComponentLSStringMsg "StatusReport" [ dgetString model "_Status" ]
                    , globalData
                    )

                else
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetLComponent "_Child" newChildComponentsList
                    , ComponentLSStringMsg "StatusReport" [ dgetString model "_Status" ]
                    , globalData
                    )

            else
                let
                    tmpChar =
                        String.slice currentPos (currentPos + 1) (dgetString model "_wholeText")
                in
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetint "_currentPos" currentPos
                    |> dsetint "_currentLength" currentLength
                    |> dsetLComponent "_Child"
                        (List.append newChildComponentsList
                            [ ( "Word" ++ String.fromInt currentPos, DialTextWordE.initComponent currentLength (ComponentStringMsg tmpChar) ) ]
                        )
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
                            -- let
                            --     ( newChildComponentsList, _ ) =
                            --         List.foldl
                            --             (\( comName, comModel ) ( tmpComponentsList, tmpComponentsMsg ) ->
                            --                 let
                            --                     ( tmpData, tmpMsg, _ ) =
                            --                         comModel.update UnknownMsg (ComponentStringMsg "OnDeBuild") globalData ( comModel.data, t )
                            --                 in
                            --                 ( List.append tmpComponentsList [ ( comName, { comModel | data = tmpData } ) ], tmpMsg :: tmpComponentsMsg )
                            --             )
                            --             ( [], [] )
                            --             (dgetLComponent model "_Child")
                            -- in
                            ( model
                                |> dsetstring "_Status" "OnDeBuild"
                              -- |> dsetLComponent "_Child" newChildComponentsList
                            , ComponentLSStringMsg "StatusReport" [ "OnDeBuild" ]
                            , globalData
                            )

                        _ ->
                            ( model, ComponentLSStringMsg "StatusReport" [ status ], globalData )

                _ ->
                    ( model, ComponentLSStringMsg "StatusReport" [ status ], globalData )


viewText : ( Data, Int ) -> GlobalData -> Renderable
viewText ( model, t ) globalData =
    let
        childComponentsList =
            dgetLComponent model "_Child"
    in
    group []
        (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) globalData) childComponentsList)
