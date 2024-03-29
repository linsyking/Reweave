module Components.Menu.Status.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Menu.Status.Status exposing (initStatus, updateStatus, viewStatus)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Status
init : the init function for Status
update : the update function for Status
view : the view function for Status
query : Status does not require query function
-}
component : Component
component =
    { name = "Status"
    , data = initStatus 0 NullComponentMsg
    , init = initStatus
    , update = updateStatus
    , view = viewStatus
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
