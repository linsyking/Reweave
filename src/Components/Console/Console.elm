module Components.Console.Console exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings.Advanced exposing (alpha)
import Char exposing (fromCode)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetbool, dsetbool, dsetstring)
import Lib.Render.Render exposing (renderText)


initModel : Int -> ComponentTMsg -> Data
initModel _ _ =
    Dict.fromList
        [ ( "input", CDString "" )
        , ( "state", CDBool False )
        ]


updateModel : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateModel msg _ gd ( d, _ ) =
    let
        command =
            dgetString d "input"

        state =
            dgetbool d "state"
    in
    case msg of
        KeyDown 192 ->
            if state then
                ( d |> dsetbool "state" (not state), ComponentStringMsg "startGameInput", gd )

            else
                ( d |> dsetbool "state" (not state), ComponentStringMsg "stopGameInput", gd )

        KeyDown 8 ->
            if state then
                ( d |> dsetstring "input" (String.dropRight 1 command), NullComponentMsg, gd )

            else
                ( d, NullComponentMsg, gd )

        KeyDown 13 ->
            let
                loadscene =
                    String.left 5 command == "load "

                scenename =
                    String.dropLeft 5 command

                ld =
                    String.dropLeft 1 scenename

                realname =
                    String.left 1 (String.toUpper scenename)

                kk =
                    String.concat [ realname, ld ]
            in
            if state then
                ( d
                    |> dsetstring "input" ""
                    |> dsetbool "state" False
                , if loadscene then
                    ComponentLStringMsg [ "nextscene", kk ]

                  else
                    ComponentStringMsg "startGameInput"
                , gd
                )

            else
                ( d, NullComponentMsg, gd )

        KeyDown x ->
            if state then
                ( d |> dsetstring "input" (String.append command (String.fromChar (Char.toLower (fromCode x)))), NullComponentMsg, gd )

            else
                ( d, NullComponentMsg, gd )

        _ ->
            ( d, NullComponentMsg, gd )


viewModel : ( Data, Int ) -> GlobalData -> Renderable
viewModel ( d, t ) gd =
    let
        command =
            dgetString d "input"

        state =
            dgetbool d "state"
    in
    if state then
        group []
            [ shapes [ alpha 0.1 ] [ rect (posToReal gd ( 20, 970 )) (widthToReal gd 1850) (heightToReal gd 40) ]
            , renderText gd 30 ("> " ++ command) "sans-seif" ( 20, 975 )
            ]

    else
        group [] []
