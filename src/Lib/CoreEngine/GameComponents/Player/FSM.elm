module Lib.CoreEngine.GameComponents.Player.FSM exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model, PlayerState(..), StateData)
import Lib.CoreEngine.GameComponents.Player.Common exposing (State)
import Lib.CoreEngine.Physics.Ground exposing (isInAir, isOnground)



--- Finite State Machine
--- Deal with the player's state


getStateFunction : String -> State
getStateFunction s =
    Maybe.withDefault nullState (List.head (List.filter (\x -> x.key == s) allStates))


getPlayerStates : Model -> List ( State, Int )
getPlayerStates model =
    case model.playerStates of
        PlayerStates x ->
            List.map (\ps -> ( getStateFunction ps.stype, ps.starttime )) x


getPlayerState : Model -> String -> ( State, Int )
getPlayerState model s =
    case model.playerStates of
        PlayerStates x ->
            let
                target =
                    List.filter (\p -> p.stype == s) x

                treal =
                    Maybe.withDefault (StateData "" 0) (List.head target)
            in
            ( getStateFunction treal.stype, treal.starttime )


delPlayerStates : Model -> String -> PlayerState
delPlayerStates model s =
    case model.playerStates of
        PlayerStates x ->
            PlayerStates (List.filter (\t -> t.stype /= s) x)


addPlayerStates : Int -> Model -> String -> PlayerState
addPlayerStates t model s =
    case model.playerStates of
        PlayerStates x ->
            PlayerStates (x ++ [ StateData s t ])


updateState : Int -> Model -> GameComponent -> GameGlobalData -> String -> ( Model, GameComponent )
updateState t model gc ggd key =
    let
        ( s, p ) =
            getPlayerState model key
    in
    ( model, s.doing p t model gc ggd )


exitState : Int -> Model -> GameComponent -> GameGlobalData -> String -> ( Model, GameComponent )
exitState t model gc ggd key =
    let
        ss =
            getPlayerStates model

        deled =
            delPlayerStates model key

        origin =
            List.head (List.filter (\( x, _ ) -> x.key == key) ss)

        tr =
            case origin of
                Just ( a, startt ) ->
                    a.onExit startt t model gc ggd

                Nothing ->
                    gc
    in
    ( { model | playerStates = deled }, tr )


addState : Int -> Model -> GameComponent -> GameGlobalData -> String -> ( Model, GameComponent )
addState t model gc ggd key =
    let
        ns =
            getStateFunction key

        newgc =
            ns.onEnter t model gc ggd
    in
    ( { model | playerStates = addPlayerStates t model key }, newgc )


queryIsState : Model -> String -> Bool
queryIsState model qs =
    List.any (\( x, _ ) -> x.key == qs) (getPlayerStates model)


getEmptyStates : Model -> List State
getEmptyStates m =
    List.filter
        (\s ->
            not (queryIsState m s.key)
        )
        allStates


allStates : List State
allStates =
    [ { key = "onground"
      , onEnter = \_ _ x _ -> x
      , doing = \_ _ _ x _ -> x
      , onExit = \_ _ _ x _ -> x
      , ifExit = \_ _ _ gc ggd -> isInAir gc ggd
      , ifEnter = \_ _ gc ggd -> isOnground gc ggd
      }
    , { key = "inair"
      , onEnter = \_ _ x _ -> x
      , doing = \_ _ _ x _ -> x
      , onExit = \_ _ _ x _ -> x
      , ifExit = \_ _ _ gc ggd -> isOnground gc ggd
      , ifEnter = \_ _ gc ggd -> isInAir gc ggd
      }
    , { key = "wolfjump"
      , onEnter = \_ _ x _ -> x
      , doing = \_ _ _ x _ -> x
      , onExit = \_ _ _ x _ -> x
      , ifExit = \_ _ _ gc ggd -> isOnground gc ggd
      , ifEnter = \_ _ _ _ -> False
      }
    ]


nullState : State
nullState =
    { key = ""
    , onEnter = \_ _ x _ -> x
    , doing = \_ _ _ x _ -> x
    , onExit = \_ _ _ x _ -> x
    , ifExit = \_ _ _ _ _ -> False
    , ifEnter = \_ _ _ _ -> False
    }
