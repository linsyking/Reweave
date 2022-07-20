module Lib.CoreEngine.GameComponents.Player.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerState(..))
import Lib.DefinedTypes.Parser exposing (dgetPlayer)
import Lib.Render.Character exposing (renderCharacterMove)
import Lib.Render.Render exposing (renderSprite, renderText)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        model =
            dgetPlayer d.extra "model"

        sn =
            model.playerStates

        ( name, time ) =
            case sn of
                PlayerStates (x :: _) ->
                    ( x.stype, x.starttime )

                _ ->
                    ( "", 0 )

        deltatime =
            t - time

        rev =
            model.islastright

        ( _, vy ) =
            d.velocity
    in
    case d.status of
        Dead _ ->
            --         [ alpha
            --     (case d.status of
            --         Alive ->
            --             1
            --         _ ->
            --             0.5
            --     )
            -- ]
            []

        _ ->
            case name of
                "inair" ->
                    [ ( group [] [], 0 ) ]

                "onground" ->
                    [ ( renderCharacterMove rev (getStateFromTime deltatime) gd (getPositionUnderCamera d.position ggd)
                      , 0
                      )
                    ]

                _ ->
                    []


getStateFromTime : Int -> Int
getStateFromTime t =
    let
        frate =
            5

        realr =
            6 * frate
    in
    modBy realr t // frate + 1


getStateNumber : Int -> Data -> String
getStateNumber t d =
    let
        model =
            dgetPlayer d.extra "model"

        sn =
            model.playerStates

        ( name, time ) =
            case sn of
                PlayerStates (x :: _) ->
                    ( x.stype, x.starttime )

                _ ->
                    ( "", 0 )

        ds =
            modBy 10 (t - time)
    in
    name ++ String.fromInt ds
