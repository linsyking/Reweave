module Components.Menu.Status.Collect.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Menu.Status.Collect.Collect exposing (initMap, updateMap, viewMap)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Collect
init : the init function for Collect
update : the update function for Collect
view : the view function for Collect
query : Collect does not require query function
-}
component : Component
component =
    { name = "Collect"
    , data = initMap 0 NullComponentMsg
    , init = initMap
    , update = updateMap
    , view = viewMap
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
