module Components.Trans.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

Transition module.

@docs component

@docs initComponent

-}

import Components.Trans.Trans exposing (initTrans, updateTrans, viewTrans)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Trans
init : the init function for Trans
update : the update function for Trans
view : the view function for Trans
query : Trans does not require query function
-}
component : Component
component =
    { name = "Trans"
    , data = initTrans 0 NullComponentMsg
    , init = initTrans
    , update = updateTrans
    , view = viewTrans
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
