module Components.Trans.Export exposing (..)

import Components.Trans.Trans exposing (initTrans, updateTrans, viewTrans)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


component : Component
component =
    { name = "Trans"
    , data = initTrans 0 NullComponentMsg
    , init = initTrans
    , update = updateTrans
    , view = viewTrans
    , query = \_ _ -> NullComponentMsg
    }


initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
