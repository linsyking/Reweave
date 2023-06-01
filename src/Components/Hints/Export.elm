module Components.Hints.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

Hints is used to display some help text on the screen.

@docs component

@docs initComponent

-}

import Components.Hints.Hints exposing (initHints, updateHints, viewHints)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Hints
init : the init function for Hints
update : the update function for Hints
view : the view function for Hints
query : Hints does not require query function
-}
component : Component
component =
    { name = "Hints"
    , data = initHints 0 NullComponentMsg
    , init = initHints
    , update = updateHints
    , view = viewHints
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
