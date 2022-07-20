module Lib.CoreEngine.GameComponents.Player.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerState(..))
import Lib.DefinedTypes.Parser exposing (dgetPlayer)
import Lib.Render.Character exposing (renderCharacterInAir, renderCharacterMove)


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

        okeys =
            model.originKeys
    in
    case d.status of
        Dead _ ->
            [ ( group [ alpha 0.5 ] [ renderCharacterMove rev -1 gd (getPositionUnderCamera d.position ggd) ]
              , 0
              )
            ]

        _ ->
            case name of
                "inair" ->
                    [ ( renderCharacterInAir (vy >= 0) rev gd (getPositionUnderCamera d.position ggd), 0 ) ]

                "onground" ->
                    if okeys.left == 0 && okeys.right == 0 then
                        [ ( renderCharacterMove rev -1 gd (getPositionUnderCamera d.position ggd)
                          , 0
                          )
                        ]

                    else
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
