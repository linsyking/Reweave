module Components.Menu.Export exposing (..)

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Menu.Menu exposing (initMenu, updateMenu, viewMenu)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
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
