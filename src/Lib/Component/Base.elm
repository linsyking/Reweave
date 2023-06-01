module Lib.Component.Base exposing
    ( ComponentTMsg(..)
    , DefinedTypes(..)
    , Component
    , Data
    , nullComponent
    )

{-|


# Component

Component is designed to have the best flexibility and compability.

You can use component almost anywhere, in layers, in gamecomponents and components themselves.

You have to manually add components in your layer and update them manually.

Therefore, components aren't capable of communicating with each other (by default).

In contrast, gamecomponents have the ability to communicate with each other.

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

This is the message that can be sent to the layer

Those entries are some basic data types we need.

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

Defined type is used to store more data types in components.

Those entries are the commonly used data types.

Note that you can use `CDDict` and `CDLComponent` to implement components inside components.

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
