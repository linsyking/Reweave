module Components.Bar.Export exposing (..)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Components.Bar.Bar exposing (initBar, updateBar)
import Components.Bar.Bar exposing (viewBar)

component : Component
component =
    { name = "HealthBar"
    , data = initBar 0 NullComponentMsg
    , init = initBar
    , update = updateBar
    , view = viewBar
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }