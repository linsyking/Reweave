module Components.Menu.Status.Export exposing (..)

import Components.Menu.Status.Status exposing (initStatus, updateStatus, viewStatus)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Status"
    , data = initStatus 0 NullComponentMsg
    , init = initStatus
    , update = updateStatus
    , view = viewStatus
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
