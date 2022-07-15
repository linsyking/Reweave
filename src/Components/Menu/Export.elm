module Components.Menu.Export exposing (..)

import Components.Menu.Menu exposing (initMenu, updateMenu, viewMenu)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Menu"
    , data = initMenu 0 NullComponentMsg
    , init = initMenu
    , update = updateMenu
    , view = viewMenu
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
