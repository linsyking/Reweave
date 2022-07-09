module Lib.Component.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Dict exposing (Dict)



--- Componentv Base


type alias Component =
    { name : String
    , data : Data
    , init : Int -> ComponentTMsg -> Data
    , update : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
    , view : ( Data, Int ) -> GlobalData -> Renderable
    , query : String -> ( Data, Int ) -> ComponentTMsg
    }


nullComponent : Component
nullComponent =
    { name = "NULL"
    , data = Dict.empty
    , init = \_ _ -> Dict.empty
    , update =
        \_ _ _ _ ->
            ( Dict.empty
            , NullComponentMsg
            , { browserViewPort = ( 1280, 720 )
              , realHeight = 720
              , realWidth = 1280
              , startLeft = 0
              , startTop = 0
              , audioVolume = 0.5
              , sprites = Dict.empty
              }
            )
    , view = \_ _ -> group [] []
    , query = \_ _ -> NullComponentMsg
    }


type ComponentTMsg
    = ComponentStringMsg String
    | ComponentIntMsg Int
    | ComponentLStringMsg (List String)
    | ComponentLSStringMsg String (List String)
    | NullComponentMsg


type alias Data =
    Dict String DefinedTypes


type DefinedTypes
    = CDInt Int
    | CDBool Bool
    | CDFloat Float
    | CDString String
    | CDLString (List String)
    | CDLComponent (List ( String, Component ))


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


dsetLComponent : String -> List ( String, Component ) -> Dict String DefinedTypes -> Dict String DefinedTypes
dsetLComponent s t f =
    Dict.update s (\_ -> Just (CDLComponent t)) f


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


findFirstFitComponentInList : String -> List ( String, Component ) -> ( String, Component )
findFirstFitComponentInList name comList =
    Maybe.withDefault ( "NONE", nullComponent ) (List.head (findComponentsInList name comList))


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
