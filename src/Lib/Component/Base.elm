module Lib.Component.Base exposing (..)

{-| This is the doc for this module

@docs ComponentTMsg

@docs DefinedTypes

@docs Component

@docs Data

@docs nullComponent

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Dict exposing (Dict)
import Lib.CoreEngine.GameComponents.Player.Base as PlayerBase



--- Component Base


{-| Component
-}
type alias Component =
    { name : String
    , data : Data
    , init : Int -> ComponentTMsg -> Data
    , update : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, List ComponentTMsg, GlobalData )
    , view : ( Data, Int ) -> GlobalData -> Renderable
    , query : String -> ( Data, Int ) -> ComponentTMsg
    }


{-| nullComponent
-}
nullComponent : Component
nullComponent =
    { name = "NULL"
    , data = Dict.empty
    , init = \_ _ -> Dict.empty
    , update =
        \_ _ gd _ ->
            ( Dict.empty
            , []
            , gd
            )
    , view = \_ _ -> group [] []
    , query = \_ _ -> NullComponentMsg
    }


{-| ComponentTMsg
-}
type ComponentTMsg
    = ComponentStringMsg String
    | ComponentIntMsg Int
    | ComponentLStringMsg (List String)
    | ComponentLSStringMsg String (List String)
    | ComponentStringDictMsg String (Dict String DefinedTypes)
    | ComponentStringIntMsg String Int
    | NullComponentMsg


{-| Data
-}
type alias Data =
    Dict String DefinedTypes


{-| DefinedTypes
-}
type DefinedTypes
    = CDInt Int
    | CDBool Bool
    | CDFloat Float
    | CDString String
    | CDLString (List String)
    | CDPlayerModel PlayerBase.Model
    | CDLComponent (List ( String, Component ))
    | CDDict (Dict String DefinedTypes)
