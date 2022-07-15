module Lib.DefinedTypes.Parser exposing (..)

import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.GameComponents.Player.Base as PlayerBase


dgetint : Dict String DefinedTypes -> String -> Int
dgetint f s =
    let
        other =
            0
    in
    case Dict.get s f of
        Just (CDInt x) ->
            x

        _ ->
            other


dsetint : String -> Int -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetint s t f =
    Dict.update s (\_ -> Just (CDInt t)) f


dgetfloat : Dict String DefinedTypes -> String -> Float
dgetfloat f s =
    let
        other =
            0
    in
    case Dict.get s f of
        Just (CDFloat x) ->
            x

        _ ->
            other


dsetfloat : String -> Float -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetfloat s t f =
    Dict.update s (\_ -> Just (CDFloat t)) f


dgetbool : Dict String DefinedTypes -> String -> Bool
dgetbool f s =
    let
        other =
            False
    in
    case Dict.get s f of
        Just (CDBool x) ->
            x

        _ ->
            other


dsetbool : String -> Bool -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetbool s t f =
    Dict.update s (\_ -> Just (CDBool t)) f


dgetString : Dict String DefinedTypes -> String -> String
dgetString f s =
    let
        other =
            ""
    in
    case Dict.get s f of
        Just (CDString x) ->
            x

        _ ->
            other


dsetstring : String -> String -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetstring s t f =
    Dict.update s (\_ -> Just (CDString t)) f


dgetLString : Dict String DefinedTypes -> String -> List String
dgetLString f s =
    let
        other =
            []
    in
    case Dict.get s f of
        Just (CDLString x) ->
            x

        _ ->
            other


dsetlstring : String -> List String -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetlstring s t f =
    Dict.update s (\_ -> Just (CDLString t)) f


dgetPlayer : Dict String DefinedTypes -> String -> PlayerBase.Model
dgetPlayer f s =
    case Dict.get s f of
        Just (CDPlayerModel x) ->
            x

        _ ->
            PlayerBase.nullModel


dsetPlayer : String -> PlayerBase.Model -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetPlayer s t f =
    Dict.update s (\_ -> Just (CDPlayerModel t)) f
