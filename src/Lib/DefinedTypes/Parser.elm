module Lib.DefinedTypes.Parser exposing
    ( dgetint
    , dsetint
    , dgetfloat
    , dsetfloat
    , dgetbool
    , dsetbool
    , dgetString
    , dsetstring
    , dgetLString
    , dsetlstring
    , dgetPlayer
    , dsetPlayer
    , dgetLComponent
    , dsetLComponent
    , findComponentsInList
    , findFirstFitComponentInList
    , setComponentsInList
    , setFirstFitComponentInList
    , dgetDict
    , dsetDict
    )

{-| This is the doc for this module

Deal with the definedtypes.

You can use this module to set/get items from DefinedType.

@docs dgetint

@docs dsetint

@docs dgetfloat

@docs dsetfloat

@docs dgetbool

@docs dsetbool

@docs dgetString

@docs dsetstring

@docs dgetLString

@docs dsetlstring

@docs dgetPlayer

@docs dsetPlayer

@docs dgetLComponent

@docs dsetLComponent

@docs findComponentsInList

@docs findFirstFitComponentInList

@docs setComponentsInList

@docs setFirstFitComponentInList

@docs dgetDict

@docs dsetDict

-}

import Dict exposing (Dict)
import Lib.Component.Base exposing (Component, DefinedTypes(..), nullComponent)
import Lib.CoreEngine.GameComponents.Player.Base as PlayerBase


{-| dgetint
-}
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


{-| dsetint
-}
dsetint : String -> Int -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetint s t f =
    Dict.update s (\_ -> Just (CDInt t)) f


{-| dgetfloat
-}
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


{-| dsetfloat
-}
dsetfloat : String -> Float -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetfloat s t f =
    Dict.update s (\_ -> Just (CDFloat t)) f


{-| dgetbool
-}
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


{-| dsetbool
-}
dsetbool : String -> Bool -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetbool s t f =
    Dict.update s (\_ -> Just (CDBool t)) f


{-| dgetString
-}
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


{-| dsetstring
-}
dsetstring : String -> String -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetstring s t f =
    Dict.update s (\_ -> Just (CDString t)) f


{-| dgetLString
-}
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


{-| dsetlstring
-}
dsetlstring : String -> List String -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetlstring s t f =
    Dict.update s (\_ -> Just (CDLString t)) f


{-| dgetPlayer
-}
dgetPlayer : Dict String DefinedTypes -> String -> PlayerBase.Model
dgetPlayer f s =
    case Dict.get s f of
        Just (CDPlayerModel x) ->
            x

        _ ->
            PlayerBase.nullModel


{-| dsetPlayer
-}
dsetPlayer : String -> PlayerBase.Model -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetPlayer s t f =
    Dict.update s (\_ -> Just (CDPlayerModel t)) f


{-| dgetLComponent
-}
dgetLComponent : Dict String DefinedTypes -> String -> List ( String, Component )
dgetLComponent f s =
    let
        other =
            []
    in
    case Dict.get s f of
        Just (CDLComponent x) ->
            x

        _ ->
            other


{-| dsetLComponent
-}
dsetLComponent : String -> List ( String, Component ) -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetLComponent s t f =
    Dict.update s (\_ -> Just (CDLComponent t)) f


{-| findComponentsInList
-}
findComponentsInList : String -> List ( String, Component ) -> List ( String, Component )
findComponentsInList name comList =
    List.filter
        (\( comName, _ ) ->
            if comName == name then
                True

            else
                False
        )
        comList


{-| findFirstFitComponentInList
-}
findFirstFitComponentInList : String -> List ( String, Component ) -> ( String, Component )
findFirstFitComponentInList name comList =
    Maybe.withDefault ( "NONE", nullComponent ) (List.head (findComponentsInList name comList))


{-| setComponentsInList
-}
setComponentsInList : String -> ( String, Component ) -> List ( String, Component ) -> List ( String, Component )
setComponentsInList name newCom comList =
    List.map
        (\( comName, comData ) ->
            if comName == name then
                newCom

            else
                ( comName, comData )
        )
        comList


{-| setFirstFitComponentInList
-}
setFirstFitComponentInList : String -> ( String, Component ) -> List ( String, Component ) -> List ( String, Component )
setFirstFitComponentInList name newCom comList =
    let
        ( comExist, comID ) =
            List.foldl
                (\( comName, _ ) cnt ->
                    if comName == name then
                        ( True, Tuple.second cnt )

                    else if Tuple.first cnt == True then
                        cnt

                    else
                        ( False, Tuple.second cnt + 1 )
                )
                ( False, 0 )
                comList
    in
    if comExist then
        List.concat [ List.take (comID - 1) comList, [ newCom ], List.drop comID comList ]

    else
        comList


{-| dgetDict
-}
dgetDict : Dict String DefinedTypes -> String -> Dict String DefinedTypes
dgetDict f s =
    let
        other =
            Dict.empty
    in
    case Dict.get s f of
        Just (CDDict x) ->
            x

        _ ->
            other


{-| dsetDict
-}
dsetDict : String -> Dict String DefinedTypes -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetDict s dict f =
    Dict.update s (\_ -> Just (CDDict dict)) f
