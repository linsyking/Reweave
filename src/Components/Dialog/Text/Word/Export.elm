module Components.Dialog.Text.Word.Export exposing (..)

import Components.Dialog.Text.Word.Word exposing (initButton, updateButton, viewButton)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Word"
    , data = initButton 1 NullComponentMsg
    , init = initButton
    , update = updateButton
    , view = viewButton
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
