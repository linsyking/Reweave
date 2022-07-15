module Components.Bar.Export exposing (..)

import Components.Bar.Bar exposing (initBar, updateBar, viewBar)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Bar"
    , data = initBar 0 NullComponentMsg
    , init = initBar
    , update = updateBar
    , view = viewBar
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
