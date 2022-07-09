module Lib.CoreEngine.GameComponents.Player.Common exposing (..)

import Dict exposing (Dict)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model)
import Lib.DefinedTypes.Base exposing (DefinedTypes)


type alias ExtraData =
    Dict String DefinedTypes


type alias State =
    { key : String
    , onEnter : Int -> Model -> GameComponent -> GameGlobalData -> GameComponent
    , doing : Int -> Int -> Model -> GameComponent -> GameGlobalData -> GameComponent
    , onExit : Int -> Int -> Model -> GameComponent -> GameGlobalData -> GameComponent
    , ifExit : Int -> Int -> Model -> GameComponent -> GameGlobalData -> Bool
    , ifEnter : Int -> Model -> GameComponent -> GameGlobalData -> Bool
    }



-- First Int is the start time, the second time is the current time
