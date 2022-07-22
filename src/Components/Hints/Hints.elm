module Components.Hints.Hints exposing
    ( initHints
    , updateHints
    , viewHints
    , genalpha
    )

{-| This is the doc for this module

@docs initHints

@docs updateHints

@docs viewHints

@docs genalpha

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.DefinedTypes.Parser exposing (dgetLString, dgetint)
import Lib.Render.Render exposing (renderText)


{-| initHints
-}
initHints : Int -> ComponentTMsg -> Data
initHints t ct =
    case ct of
        ComponentLStringMsg (start :: px :: py :: fsize :: xs) ->
            Dict.fromList
                [ ( "hints", CDLString xs )
                , ( "starttime", CDInt t )
                , ( "posx", CDInt (Maybe.withDefault 0 (String.toInt px)) )
                , ( "posy", CDInt (Maybe.withDefault 0 (String.toInt py)) )
                , ( "size", CDInt (Maybe.withDefault 0 (String.toInt fsize)) )
                , ( "st", CDInt (Maybe.withDefault 0 (String.toInt start)) )
                ]

        _ ->
            Dict.empty


{-| updateHints
-}
updateHints : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
updateHints _ _ gd ( d, _ ) =
    ( d, [], gd )


{-| viewHints
-}
viewHints : ( Data, Int ) -> GlobalData -> Renderable
viewHints ( d, t ) gd =
    let
        allhints =
            dgetLString d "hints"

        st =
            dgetint d "starttime"

        pp =
            ( dgetint d "posx", dgetint d "posy" )

        fs =
            dgetint d "size"

        startshow =
            dgetint d "st"

        elapsed =
            t - st

        qstart =
            elapsed - startshow

        stage =
            modBy 280 qstart

        cursentn =
            qstart // 280

        curh =
            Maybe.withDefault "" (List.head (List.drop cursentn allhints))
    in
    if qstart < 0 then
        group [] []

    else
        group [ alpha (genalpha stage) ] [ renderText gd fs curh "Times New Roman" pp ]


{-| genalpha
-}
genalpha : Int -> Float
genalpha k =
    if k < 0 then
        0

    else if k < 70 then
        1 / 70 * toFloat k

    else if k < 170 then
        1

    else if k < 240 then
        -1 / 70 * toFloat k + 24 / 7

    else
        0
