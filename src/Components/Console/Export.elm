module Components.Console.Export exposing (..)

import Components.Console.Console exposing (initModel, updateModel, viewModel)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Console"
    , data = initModel 0 NullComponentMsg
    , init = initModel
    , update = updateModel
    , view = viewModel
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
