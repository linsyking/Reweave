module Components.Menu.Settings.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Menu.Settings.Settings exposing (initSettings, updateSettings, viewSettings)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Settings
init : the init function for Settings
update : the update function for Settings
view : the view function for Settings
query : Settings does not require query function
-}
component : Component
component =
    { name = "Settings"
    , data = initSettings 0 NullComponentMsg
    , init = initSettings
    , update = updateSettings
    , view = viewSettings
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
