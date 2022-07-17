module Lib.CoreEngine.FrontgroundLayer.Model exposing (..)

import Array
import Base exposing (GlobalData, Msg(..))
import Canvas exposing (group)
import Components.Menu.Export as Menu
import Components.Trans.Export as Trans
import Lib.Component.Base exposing (ComponentTMsg(..))
import Lib.Component.ComponentHandler exposing (updateSingleComponent)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Common exposing (Model)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Lib.Scene.Base exposing (EngineT)


initModel : Int -> LayerMsg -> GameGlobalData -> Model
initModel t lm _ =
    case lm of
        LayerTimeSeries f ->
            { render = f
            , components =
                Array.fromList
                    [ Trans.initComponent t (ComponentLStringMsg [ "end", "cloud", "0" ])
                    , Menu.initComponent t NullComponentMsg
                    ]
            }

        _ ->
            { render = \_ _ _ -> group [] [], components = Array.empty }


updateModel : Msg -> GlobalData -> LayerMsg -> ( Model, Int ) -> GameGlobalData -> ( ( Model, GameGlobalData, List ( LayerTarget, LayerMsg ) ), GlobalData )
updateModel msg gd lm ( model, t ) ggd =
    case lm of
        LayerExitMsg _ s ->
            let
                ( newcs, _, newgd ) =
                    updateSingleComponent UnknownMsg (ComponentLStringMsg [ "start", "cloud", "50", "nextscene", s ]) gd t 0 model.components
            in
            ( ( { model | components = newcs }, ggd, [] ), newgd )

        LayerRestartMsg ->
            let
                ( newcs, _, newgd ) =
                    updateSingleComponent UnknownMsg (ComponentLStringMsg [ "start", "cloud", "10", "restart" ]) gd t 0 model.components

                ( newcs2, _, newgd2 ) =
                    updateSingleComponent UnknownMsg (ComponentStringMsg "Activate") newgd t 1 newcs
            in
            ( ( { model | components = newcs2 }, ggd, [] ), newgd2 )

        _ ->
            case msg of
                Tick _ ->
                    let
                        ( newcs, rmsg, newgd ) =
                            updateSingleComponent msg NullComponentMsg gd t 0 model.components

                        ( newcs1, _, newgd1 ) =
                            updateSingleComponent msg NullComponentMsg newgd t 1 newcs
                    in
                    case rmsg of
                        ComponentLStringMsg ("nextscene" :: s :: _) ->
                            ( ( { model | components = newcs1 }, ggd, [ ( LayerParentScene, LayerExitMsg (EngineT ggd.energy s) s ) ] ), newgd1 )

                        ComponentLStringMsg ("restart" :: _) ->
                            ( ( { model | components = newcs1 }, ggd, [ ( LayerParentScene, LayerExitMsg (EngineT 0 ggd.currentScene) ggd.currentScene ) ] ), newgd1 )

                        _ ->
                            ( ( { model | components = newcs1 }, ggd, [] ), newgd1 )

                _ ->
                    let
                        ( newcs, _, newgd ) =
                            updateSingleComponent msg NullComponentMsg gd t 1 model.components
                    in
                    ( ( { model | components = newcs }, ggd, [] ), gd )
