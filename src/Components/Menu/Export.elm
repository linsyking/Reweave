module Components.Menu.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

Menu Component.

@docs component

@docs initComponent

-}

import Components.Menu.Menu exposing (initMenu, updateMenu, viewMenu)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Menu
init : the init function for Menu
update : the update function for Menu
view : the view function for Menu
query : Menu does not require query function
-}
component : Component
component =
    { name = "Menu"
    , data = initMenu 0 NullComponentMsg
    , init = initMenu
    , update = updateMenu
    , view = viewMenu
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
