module Lib.CoreEngine.GameComponents.Player.Common exposing (..)

{-| This is the doc for this module

@docs ExtraData

@docs State

-}

import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model)


{-| ExtraData
-}
type alias ExtraData =
    Dict String DefinedTypes


{-| State
-}
type alias State =
    { key : String
    , onEnter : Int -> Model -> Data -> GameGlobalData -> Data
    , doing : Int -> Int -> Model -> Data -> GameGlobalData -> Data
    , onExit : Int -> Int -> Model -> Data -> GameGlobalData -> Data
    , ifExit : Int -> Int -> Model -> Data -> GameGlobalData -> Bool
    , ifEnter : Int -> Model -> Data -> GameGlobalData -> Bool
    }



-- First Int is the start time, the second time is the current time
