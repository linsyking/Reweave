module Components.Dialog.NextButton.Export exposing (..)

import Components.Dialog.NextButton.NextButton exposing (initButton, updateButton, viewButton)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "NextButton"
    , data = initButton 0 NullComponentMsg
    , init = initButton
    , update = updateButton
    , view = viewButton
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
