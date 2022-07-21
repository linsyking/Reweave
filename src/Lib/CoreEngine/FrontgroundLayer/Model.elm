module Lib.CoreEngine.FrontgroundLayer.Model exposing (..)

import Array
import Base exposing (GlobalData, Msg(..))
import Canvas exposing (group)
import Components.Bar.Export as Bar
import Components.Console.Export as Console
import Components.Menu.Export as Menu
import Components.Trans.Export as Trans
import Lib.Component.Base exposing (ComponentTMsg(..))
import Lib.Component.ComponentHandler exposing (updateComponents, updateSingleComponentByName)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (EngineT, PlayerInitPosition(..))
import Time exposing (posixToMillis)


initModel : Int -> LayerMsg -> GameGlobalData -> Model
initModel t lm _ =
    case lm of
        LayerCTMsg f ->
            { render = f.timeseries
            , components =
                Array.append
                    (Array.fromList
                        [ Bar.initComponent t NullComponentMsg
                        , Trans.initComponent t (ComponentLStringMsg [ "end", "cloud", "0" ])
                        , Menu.initComponent t NullComponentMsg
                        , Console.initComponent t NullComponentMsg
                        ]
                    )
                    f.components
            , fpsrepo = []
            }

        _ ->
            { render = \_ _ _ -> group [] [], components = Array.empty, fpsrepo = [] }


dealComponentsMsg : ComponentTMsg -> Model -> GlobalData -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
dealComponentsMsg rmsg model gd ggd =
    case rmsg of
        ComponentLStringMsg ("nextscene" :: s :: _) ->
            ( ( model, ggd, [ ( LayerParentScene, LayerExitMsg (EngineT ggd.energy DefaultPlayerPosition) s ) ] ), gd )

        ComponentLStringMsg ("restart" :: _) ->
            ( ( model, ggd, [ ( LayerParentScene, LayerExitMsg (EngineT 0 DefaultPlayerPosition) ggd.currentScene ) ] ), gd )

        ComponentStringMsg "stopGameInput" ->
            ( ( model, ggd, [ ( LayerName "Game", LayerStringMsg "stopinput" ) ] ), gd )

        ComponentStringMsg "startGameInput" ->
            ( ( model, ggd, [ ( LayerName "Game", LayerStringMsg "startinput" ) ] ), gd )

        ComponentStringIntMsg "addenergy" v ->
            ( ( model, { ggd | energy = ggd.energy + toFloat v }, [] ), gd )

        _ ->
            ( ( model, ggd, [] ), gd )


dealAllComponentMsg : List ComponentTMsg -> Model -> GlobalData -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
dealAllComponentMsg rmsg model gd ggd =
    List.foldl
        (\lmt ( ( xm, xggd, xlm ), xgd ) ->
            let
                ( ( nm, nggd, nlm ), ngd ) =
                    dealComponentsMsg lmt xm xgd xggd
            in
            ( ( nm, nggd, xlm ++ nlm ), ngd )
        )
        ( ( model, ggd, [] ), gd )
        rmsg


updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd lm ( model, t ) ggd =
    case lm of
        LayerExitMsg _ s ->
            let
                ( newcs, _, newgd ) =
                    updateSingleComponentByName UnknownMsg (ComponentLStringMsg [ "start", "cloud", "50", "nextscene", s ]) gd t "Trans" model.components
            in
            ( ( { model | components = newcs }, ggd, [] ), newgd )

        LayerRestartMsg ->
            let
                ( newcs, _, newgd ) =
                    updateSingleComponentByName UnknownMsg (ComponentLStringMsg [ "start", "cloud", "10", "restart" ]) gd t "Trans" model.components
            in
            ( ( { model | components = newcs }, ggd, [] ), newgd )

        _ ->
            case msg of
                Tick tick ->
                    let
                        ( newcs, rmsg, newgd ) =
                            updateComponents t msg gd model.components

                        ( newcs2, _, _ ) =
                            updateSingleComponentByName msg (ComponentIntMsg (floor (ggd.energy / 2000 * 100))) gd t "Bar" newcs

                        curtime =
                            posixToMillis tick

                        newfpsrepo =
                            if List.length model.fpsrepo >= 10 then
                                List.drop 1 model.fpsrepo ++ [ curtime ]

                            else
                                model.fpsrepo ++ [ curtime ]

                        addfpsmodel =
                            { model | fpsrepo = newfpsrepo }
                    in
                    dealAllComponentMsg rmsg { addfpsmodel | components = newcs2 } newgd ggd

                MouseDown 0 _ ->
                    let
                        ( newcs, _, newgd ) =
                            updateSingleComponentByName msg NullComponentMsg gd t "Menu" model.components
                    in
                    ( ( { model | components = newcs }, ggd, [] ), newgd )

                KeyDown 27 ->
                    let
                        ( newcs, _, newgd ) =
                            updateSingleComponentByName UnknownMsg (ComponentLStringMsg [ "Activate", "NONE" ]) gd t "Menu" model.components
                    in
                    ( ( { model | components = newcs }, ggd, [] ), newgd )

                KeyDown _ ->
                    let
                        ( newcs, rmsg, newgd ) =
                            updateComponents t msg gd model.components
                    in
                    dealAllComponentMsg rmsg { model | components = newcs } newgd ggd

                _ ->
                    ( ( model, ggd, [] ), gd )
