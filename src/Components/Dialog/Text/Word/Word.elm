module Components.Dialog.Text.Word.Word exposing
    ( initWord
    , randomPos
    , updateWord
    , viewWord
    )

{-| This is the doc for this module

@docs initWord

@docs randomPos

@docs updateWord

@docs viewWord

-}

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLString, dgetString, dgetint, dsetint, dsetlstring, dsetstring)
import Lib.Render.Render exposing (renderText)
import Random



-- OnBuild -> OnShow -> OnDeBuild
-- OnShow : OnLoadChild -> (OnShowChild ->) OnDeChild (OnDeconstructChild)


{-| initWord
-}
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


{-| randomPos
-}
randomPos : Int -> Int -> Int -> Int
randomPos t l r =
    Tuple.first (Random.step (Random.int l r) (Random.initialSeed t))


{-| updateWord
-}
updateWord : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateWord mainMsg comMsg globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                timer =
                    dgetint model "_Timer" + 1
            in
            if timer > 20 then
                if dgetString model "_Status" == "OnBuild" then
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnShow"
                    , [ ComponentLSStringMsg "StatusReport" [ "OnShow" ] ]
                    , globalData
                    )

                else if dgetString model "_Status" == "OnDeBuild" then
                    ( model
                        |> dsetint "_Timer" timer
                        |> dsetstring "_Status" "OnEnd"
                    , [ ComponentLSStringMsg "StatusReport" [ "OnEnd" ] ]
                    , globalData
                    )

                else
                    ( model
                        |> dsetint "_Timer" timer
                    , [ ComponentLSStringMsg "StatusReport" [ dgetString model "_Status" ] ]
                    , globalData
                    )

            else if dgetString model "_Status" == "OnDeBuild" then
                let
                    tmpCrashPos =
                        dgetLString model "CrashPos"

                    newCrashPos =
                        List.map
                            (\str ->
                                let
                                    list =
                                        String.split "_" str

                                    posX =
                                        Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head list)))

                                    posY =
                                        Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head (List.reverse list))))
                                in
                                String.fromInt (posX + randomPos (t + posY) -10 0) ++ "_" ++ String.fromInt (posY + randomPos (t + posX) -2 2)
                            )
                            tmpCrashPos
                in
                ( model
                    |> dsetint "_Timer" timer
                    |> dsetlstring "CrashPos" newCrashPos
                , [ ComponentLSStringMsg "StatusReport" [ dgetString model "_Status" ] ]
                , globalData
                )

            else
                ( model
                    |> dsetint "_Timer" timer
                , [ ComponentLSStringMsg "StatusReport" [ dgetString model "_Status" ] ]
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
                                |> dsetstring "_Status" "OnDeBuild"
                                |> dsetint "_Timer" 0
                                |> dsetlstring "CrashPos" (List.repeat 20 (String.fromInt (dgetint model "_Position" + 400) ++ "_" ++ String.fromInt 150))
                            , [ ComponentLSStringMsg "StatusReport" [ "OnDeBuild" ] ]
                            , globalData
                            )

                        _ ->
                            ( model, [ ComponentLSStringMsg "StatusReport" [ status ] ], globalData )

                _ ->
                    ( model, [ ComponentLSStringMsg "StatusReport" [ status ] ], globalData )


{-| viewWord
-}
viewWord : ( Data, Int ) -> GlobalData -> Renderable
viewWord ( model, t ) globalData =
    let
        timer =
            dgetint model "_Timer"

        position =
            dgetint model "_Position"

        status =
            dgetString model "_Status"
    in
    case status of
        "OnBuild" ->
            group [ alpha (toFloat timer / 20.0) ]
                [ renderText globalData 35 (dgetString model "Word") "Courier New" ( 400 + position, 130 ) ]

        "OnShow" ->
            group []
                [ renderText globalData 35 (dgetString model "Word") "Courier New" ( 400 + position, 130 ) ]

        "OnDeBuild" ->
            group [ alpha (1.0 - toFloat timer / 20.0) ]
                (List.append [ renderText globalData 35 (dgetString model "Word") "Courier New" ( 400 + position, 130 ) ]
                    (List.map
                        (\str ->
                            let
                                list =
                                    String.split "_" str

                                posX =
                                    Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head list)))

                                posY =
                                    Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head (List.reverse list))))
                            in
                            shapes [ alpha (1.0 - toFloat timer / 10.0), fill Color.black ] [ rect (posToReal globalData ( posX, posY )) (widthToReal globalData 2) (heightToReal globalData 2) ]
                        )
                        (dgetLString model "CrashPos")
                    )
                )

        _ ->
            group [] []
