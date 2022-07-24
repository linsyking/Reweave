module Lib.CoreEngine.FrontgroundLayer.Model exposing
    ( initModel
    , dealComponentsMsg
    , dealAllComponentMsg
    , updateModel
    )

{-| This is the doc for this module

@docs initModel

@docs dealComponentsMsg

@docs dealAllComponentMsg

@docs updateModel

-}

import Array
import Base exposing (GlobalData, LSInfo, Msg(..))
import Canvas exposing (group)
import Components.Bar.Export as Bar
import Components.Console.Export as Console
import Components.Menu.Export as Menu
import Components.Trans.Export as Trans
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), DefinedTypes(..))
import Lib.Component.ComponentHandler exposing (updateComponents, updateSingleComponentByName)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition(..))
import Lib.CoreEngine.GameLayer.Common exposing (addenergy)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Resources.Background exposing (findBackgroundImage)
import Lib.Scene.Base exposing (EngineT, nullEngineT)
import Time exposing (posixToMillis)


{-| initModel
-}
initModel : Int -> LayerMsg -> GameGlobalData -> Model
initModel t lm _ =
    case lm of
        LayerCTMsg f ->
            { render = f.timeseries
            , components =
                Array.append
                    f.components
                    (Array.fromList
                        [ Bar.initComponent t NullComponentMsg
                        , Trans.initComponent t (ComponentLStringMsg [ "end", "cloud", "0" ])
                        , Menu.initComponent t NullComponentMsg
                        , Console.initComponent t NullComponentMsg
                        ]
                    )
            , fpsrepo = []
            , ispaused = False
            , exitinfo = nullEngineT
            , savePoint = Nothing
            }

        _ ->
            { render = \_ _ _ -> group [] []
            , components = Array.empty
            , fpsrepo = []
            , ispaused = False
            , exitinfo = nullEngineT
            , savePoint = Nothing
            }


{-| dealComponentsMsg
-}
dealComponentsMsg : ComponentTMsg -> Model -> GlobalData -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
dealComponentsMsg rmsg model gd ggd =
    case rmsg of
        ComponentLStringMsg ("nextscene" :: s :: _) ->
            let
                originet =
                    model.exitinfo

                originenergy =
                    originet.energy

                newenergy =
                    if List.any (\x -> x == s) gd.scenesFinished then
                        originenergy

                    else
                        addenergy originenergy 500

                newexitmsg =
                    LayerExitMsg { originet | energy = newenergy, collectedMonsters = ggd.collectedMonsters } s 0
            in
            ( ( model, ggd, [ ( LayerParentScene, newexitmsg ) ] ), { gd | scenesFinished = gd.scenesFinished ++ [ ggd.currentScene ], localstorage = LSInfo ggd.collectedMonsters s } )

        ComponentLStringMsg ("restart" :: _) ->
            -- Final Restart
            case model.savePoint of
                Nothing ->
                    ( ( model, ggd, [ ( LayerParentScene, LayerExitMsg model.exitinfo ggd.currentScene 0 ) ] ), gd )

                Just ( p, e ) ->
                    let
                        oldex =
                            model.exitinfo
                    in
                    ( ( model, ggd, [ ( LayerParentScene, LayerExitMsg { oldex | playerPosition = CustomPlayerPosition p, energy = e } ggd.currentScene 0 ) ] ), gd )

        ComponentStringMsg "stopGameInput" ->
            ( ( model, ggd, [ ( LayerName "Game", LayerStringMsg "stopinput" ) ] ), gd )

        ComponentStringMsg "restart" ->
            ( ( model, { ggd | ingamepause = True, settingpause = False }, [ ( LayerName "Frontground", LayerRestartMsg 10 ) ] ), gd )

        ComponentStringMsg "OnClose" ->
            ( ( model, ggd, [] ), gd )

        ComponentStringMsg "visualaid" ->
            ( ( model, ggd, [] ), { gd | visualaid = not gd.visualaid } )

        ComponentStringMsg "continue" ->
            ( ( { model | ispaused = False }, { ggd | ingamepause = False, settingpause = False }, [ ( LayerName "Game", LayerStringMsg "clearPlayerInput" ) ] ), gd )

        ComponentStringMsg "skipcutscene" ->
            ( ( { model | ispaused = False }, { ggd | ingamepause = False, settingpause = False }, [ ( LayerName "Game", LayerStringMsg "skipcutscene" ) ] ), gd )

        ComponentStringMsg "startGameInput" ->
            ( ( model, ggd, [ ( LayerName "Game", LayerStringMsg "startinput" ) ] ), gd )

        ComponentStringIntMsg "addenergy" v ->
            ( ( model, { ggd | energy = ggd.energy + toFloat v }, [] ), gd )

        _ ->
            ( ( model, ggd, [] ), gd )


{-| dealAllComponentMsg
-}
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


{-| updateModel
-}
updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd lm ( model, t ) ggd =
    case lm of
        LayerExitMsg et s transt ->
            let
                ( newcs, _, newgd ) =
                    updateSingleComponentByName UnknownMsg (ComponentLStringMsg [ "start", "cloud", String.fromInt transt, "nextscene", s ]) gd t "Trans" model.components
            in
            ( ( { model | components = newcs, exitinfo = et }, ggd, [] ), newgd )

        LayerRestartMsg transt ->
            let
                ( newcs, _, newgd ) =
                    updateSingleComponentByName UnknownMsg (ComponentLStringMsg [ "start", "cloud", String.fromInt transt, "restart", ggd.currentScene ]) gd t "Trans" model.components
            in
            ( ( { model
                    | components = newcs
                    , exitinfo =
                        EngineT
                            (if ggd.energy >= 500 then
                                500

                             else if ggd.energy <= 300 then
                                300

                             else
                                ggd.energy
                            )
                            DefaultPlayerPosition
                            ggd.collectedMonsters
                            ggd.specialState
                }
              , ggd
              , []
              )
            , newgd
            )

        LayerInfoPositionMsg "save" p ->
            ( ( { model | savePoint = Just ( p, ggd.energy ) }, ggd, [] ), gd )

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
                        ( newcs, newmsg, newgd ) =
                            updateSingleComponentByName msg NullComponentMsg gd t "Menu" model.components
                    in
                    dealAllComponentMsg newmsg { model | components = newcs } newgd ggd

                KeyDown 27 ->
                    if model.ispaused then
                        let
                            ( newcs, newmsg, newgd ) =
                                updateSingleComponentByName UnknownMsg (ComponentStringDictMsg "Close" Dict.empty) gd t "Menu" model.components

                            ( ( nmodel, nggd, nmsg ), ngd ) =
                                dealAllComponentMsg newmsg { model | components = newcs, ispaused = False } newgd { ggd | ingamepause = False, settingpause = False }
                        in
                        ( ( nmodel, nggd, nmsg ++ [ ( LayerName "Game", LayerStringMsg "clearPlayerInput" ) ] ), ngd )

                    else
                        let
                            ( newcs, _, newgd ) =
                                updateSingleComponentByName UnknownMsg
                                    (ComponentStringDictMsg "Activate"
                                        (Dict.fromList
                                            [ ( "collectedMonsters", CDLString ggd.collectedMonsters )
                                            , ( "currentScene", CDString ggd.currentScene )
                                            , ( "energy", CDInt (floor ggd.energy) )
                                            , ( "bgimg", CDString (findBackgroundImage ggd.currentScene) )
                                            ]
                                        )
                                    )
                                    gd
                                    t
                                    "Menu"
                                    model.components
                        in
                        ( ( { model | components = newcs, ispaused = True }, { ggd | ingamepause = True, settingpause = True }, [] ), newgd )

                KeyDown _ ->
                    let
                        ( newcs, rmsg, newgd ) =
                            updateComponents t msg gd model.components
                    in
                    dealAllComponentMsg rmsg { model | components = newcs } newgd ggd

                _ ->
                    ( ( model, ggd, [] ), gd )
