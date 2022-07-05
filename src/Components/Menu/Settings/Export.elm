module Components.Menu.Settings.Export exposing (..)

import Components.Menu.Settings.Settings exposing (initSettings, updateSettings, viewSettings)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Settings"
    , data = initSettings 0 NullComponentMsg
    , init = initSettings
    , update = updateSettings
    , view = viewSettings
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
