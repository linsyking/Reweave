module Components.Menu.Settings.Audio.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Menu.Settings.Audio.Audio exposing (initMap, updateMap, viewMap)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Audio
init : the init function for Audio
update : the update function for Audio
view : the view function for Audio
query : Audio does not require query function
-}
component : Component
component =
    { name = "Audio"
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
