module Lib.Component.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Dict exposing (Dict)
import Lib.DefinedTypes.Base exposing (DefinedTypes)



--- Component Base


type alias Component =
    { name : String
    , data : Data
    , init : Int -> ComponentTMsg -> Data
    , update : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
    , view : ( Data, Int ) -> GlobalData -> Renderable
    , query : String -> ( Data, Int ) -> ComponentTMsg
    }


type ComponentTMsg
    = ComponentStringMsg String
    | ComponentIntMsg Int
    | ComponentLStringMsg (List String)
    | ComponentLSStringMsg String (List String)
    | NullComponentMsg


type alias Data =
    Dict String DefinedTypes
