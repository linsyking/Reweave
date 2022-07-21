module Components.Dialog.Export exposing (..)

import Components.Dialog.Dialog exposing (initDialog, updateDialog, viewDialog)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Menu"
    , data = initDialog 0 NullComponentMsg
    , init = initDialog
    , update = updateDialog
    , view = viewDialog
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
