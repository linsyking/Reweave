module Components.Menu.Settings.Play.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Menu.Settings.Play.Play exposing (initMap, updateMap, viewMap)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Play
init : the init function for Play
update : the update function for Play
view : the view function for Play
query : Play does not require query function
-}
component : Component
component =
    { name = "Play"
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
