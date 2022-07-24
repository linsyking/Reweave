module Lib.CoreEngine.GameComponents.Player.Display exposing
    ( view
    , getStateFromTime
    , getStateNumber
    )

{-| This is the doc for this module

@docs view

@docs getStateFromTime

@docs getStateNumber

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerState(..))
import Lib.DefinedTypes.Parser exposing (dgetPlayer)
import Lib.Render.Character exposing (renderCharacterInAir, renderCharacterMove)


{-| view
-}
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

        listPos =
            model.listPosition
    in
    case d.status of
        Dead _ ->
            [ ( group [ alpha 0.5 ] [ renderCharacterMove rev -1 gd (getPositionUnderCamera d.position ggd) ]
              , 0
              )
            ]

        _ ->
            List.append
                (Tuple.first
                    (List.foldl
                        (\( posX, posY, ( stype, dtime ) ) ( list, index ) ->
                            case name of
                                "inair" ->
                                    ( ( group [ alpha (0.1 * index) ] [ renderCharacterInAir (vy >= 0) rev gd (getPositionUnderCamera ( posX, posY ) ggd) ], 0 ) :: list, index + 1 )

                                "onground" ->
                                    if okeys.left == 0 && okeys.right == 0 then
                                        ( ( group [ alpha (0.1 * index) ] [ renderCharacterMove rev -1 gd (getPositionUnderCamera ( posX, posY ) ggd) ]
                                          , 0
                                          )
                                            :: list
                                        , index + 1
                                        )

                                    else
                                        ( ( group [ alpha (0.1 * index) ] [ renderCharacterMove rev (getStateFromTime dtime) gd (getPositionUnderCamera ( posX, posY ) ggd) ]
                                          , 0
                                          )
                                            :: list
                                        , index + 1
                                        )

                                _ ->
                                    ( ( group [] [], 0 ) :: list, index + 1 )
                        )
                        ( [], 0 )
                        listPos
                    )
                )
                (case name of
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
                )


{-| getStateFromTime
-}
getStateFromTime : Int -> Int
getStateFromTime t =
    let
        frate =
            5

        realr =
            6 * frate
    in
    modBy realr t // frate + 1


{-| getStateNumber
-}
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
