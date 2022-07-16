module Lib.Component.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Dict exposing (Dict)
import Lib.CoreEngine.GameComponents.Player.Base as PlayerBase



--- Component Base


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
        \_ _ gd _ ->
            ( Dict.empty
            , NullComponentMsg
            , gd
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
    | CDPlayerModel PlayerBase.Model
    | CDLComponent (List ( String, Component ))
