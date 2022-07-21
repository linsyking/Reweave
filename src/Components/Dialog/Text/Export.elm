module Components.Dialog.Text.Export exposing (..)

import Components.Dialog.Text.Text exposing (initText, updateText, viewText)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Text"
    , data = initText 0 NullComponentMsg
    , init = initText
    , update = updateText
    , view = viewText
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
