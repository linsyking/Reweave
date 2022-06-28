module FSM exposing (..)

import Collision exposing (..)
import Common exposing (..)



--- Finite State Machine
--- Deal with the player's state


getPlayerStates : Model -> List State
getPlayerStates model =
    case model.playerStates of
        PlayerStates x ->
            x


exitState : Model -> String -> Model
exitState model key =
    let
        ss =
            getPlayerStates model

        ns =
            List.filter (\x -> x.key /= key) ss

        origin =
            List.head (List.filter (\x -> x.key == key) ss)

        tr =
            case origin of
                Just a ->
                    a.onExit

                Nothing ->
                    \x -> x
    in
    tr { model | playerStates = PlayerStates ns }


addState : Model -> String -> Model
addState model name =
    let
        ns =
            getStatePrototype model name

        nsl =
            List.append (getPlayerStates model) [ ns ]
    in
    ns.onEnter { model | playerStates = PlayerStates nsl }


queryIsState : Model -> String -> Bool
queryIsState model qs =
    List.any (\x -> x.key == qs) (getPlayerStates model)


isInAir : Model -> Bool
isInAir model =
    if canJump (getPlayer model) model then
        False

    else
        True


isOnground : Model -> Bool
isOnground model =
    not (isInAir model)


getStatePrototype : Model -> String -> State
getStatePrototype model qs =
    let
        nl =
            allStates model

        ns =
            List.filter (\x -> (Tuple.first x).key == qs) nl

        nr =
            List.head ns
    in
    case nr of
        Just x ->
            Tuple.first x

        Nothing ->
            { key = "name"
            , starttime = model.currentTime
            , onEnter = \x -> x
            , doing = \x -> x
            , onExit = \x -> x
            , ifExit = \_ -> False
            }


allStates : Model -> List ( State, Model -> Bool )
allStates model =
    [ ( { key = "onground"
        , starttime = model.currentTime
        , onEnter = \x -> x
        , doing = \x -> x
        , onExit = \x -> x
        , ifExit = isInAir
        }
      , isOnground
      )
    , ( { key = "inair"
        , starttime = model.currentTime
        , onEnter = \x -> x
        , doing = \x -> x
        , onExit = \x -> x
        , ifExit = isOnground
        }
      , isInAir
      )
    , ( { key = "wolfjump"
        , starttime = model.currentTime
        , onEnter = \x -> x
        , doing = \x -> x
        , onExit = \x -> x
        , ifExit = isOnground
        }
      , \_ -> False
      )
    ]
