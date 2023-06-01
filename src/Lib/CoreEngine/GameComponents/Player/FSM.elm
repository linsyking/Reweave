module Lib.CoreEngine.GameComponents.Player.FSM exposing
    ( getStateFunction
    , getPlayerStates
    , getPlayerState
    , delPlayerStates
    , addPlayerStates
    , updateState
    , exitState
    , addState
    , queryIsState
    , queryStateStarttime
    , getEmptyStates
    , allStates
    , nullState
    )

{-| This is the doc for this module

@docs getStateFunction

@docs getPlayerStates

@docs getPlayerState

@docs delPlayerStates

@docs addPlayerStates

@docs updateState

@docs exitState

@docs addState

@docs queryIsState

@docs queryStateStarttime

@docs getEmptyStates

@docs allStates

@docs nullState

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model, PlayerState(..), StateData)
import Lib.CoreEngine.GameComponents.Player.Common exposing (State)
import Lib.CoreEngine.Physics.Ground exposing (isInAir, isOnground)



--- Finite State Machine
--- Deal with the player's state


{-| getStateFunction
-}
getStateFunction : String -> State
getStateFunction s =
    Maybe.withDefault nullState (List.head (List.filter (\x -> x.key == s) allStates))


{-| getPlayerStates
-}
getPlayerStates : Model -> List ( State, Int )
getPlayerStates model =
    case model.playerStates of
        PlayerStates x ->
            List.map (\ps -> ( getStateFunction ps.stype, ps.starttime )) x


{-| getPlayerState
-}
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


{-| delPlayerStates
-}
delPlayerStates : Model -> String -> PlayerState
delPlayerStates model s =
    case model.playerStates of
        PlayerStates x ->
            PlayerStates (List.filter (\t -> t.stype /= s) x)


{-| addPlayerStates
-}
addPlayerStates : Int -> Model -> String -> PlayerState
addPlayerStates t model s =
    case model.playerStates of
        PlayerStates x ->
            PlayerStates (x ++ [ StateData s t ])


{-| updateState
-}
updateState : Int -> Model -> Data -> GameGlobalData -> String -> ( Model, Data )
updateState t model gc ggd key =
    let
        ( s, p ) =
            getPlayerState model key
    in
    ( model, s.doing p t model gc ggd )


{-| exitState
-}
exitState : Int -> Model -> Data -> GameGlobalData -> String -> ( Model, Data )
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


{-| addState
-}
addState : Int -> Model -> Data -> GameGlobalData -> String -> ( Model, Data )
addState t model gc ggd key =
    let
        ns =
            getStateFunction key

        newgc =
            ns.onEnter t model gc ggd
    in
    ( { model | playerStates = addPlayerStates t model key }, newgc )


{-| queryIsState
-}
queryIsState : Model -> String -> Bool
queryIsState model qs =
    List.any (\( x, _ ) -> x.key == qs) (getPlayerStates model)


{-| queryStateStarttime
-}
queryStateStarttime : Model -> String -> Int
queryStateStarttime model s =
    let
        alls =
            List.filter (\( x, _ ) -> x.key == s) (getPlayerStates model)
    in
    case alls of
        ( _, ss ) :: _ ->
            ss

        _ ->
            0


{-| getEmptyStates
-}
getEmptyStates : Model -> List State
getEmptyStates m =
    List.filter
        (\s ->
            not (queryIsState m s.key)
        )
        allStates


{-| allStates
-}
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


{-| nullState
-}
nullState : State
nullState =
    { key = ""
    , onEnter = \_ _ x _ -> x
    , doing = \_ _ _ x _ -> x
    , onExit = \_ _ _ x _ -> x
    , ifExit = \_ _ _ _ _ -> False
    , ifEnter = \_ _ _ _ -> False
    }
