module Components.Dialog.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

Dialogue component. Included in CutScene GC.

@docs component

@docs initComponent

-}

import Components.Dialog.Dialog exposing (initDialog, updateDialog, viewDialog)
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
    , data = initDialog 0 NullComponentMsg
    , init = initDialog
    , update = updateDialog
    , view = viewDialog
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
