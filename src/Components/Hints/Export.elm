module Components.Hints.Export exposing (..)

import Components.Hints.Hints exposing (initHints, updateHints, viewHints)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Hints"
    , data = initHints 0 NullComponentMsg
    , init = initHints
    , update = updateHints
    , view = viewHints
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
