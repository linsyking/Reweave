module Components.Dialog.Text.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Dialog.Text.Text exposing (initText, updateText, viewText)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Text
init : the init function for Text
update : the update function for Text
view : the view function for Text
query : Text does not require query function
-}
component : Component
component =
    { name = "Text"
    , data = initText 0 NullComponentMsg
    , init = initText
    , update = updateText
    , view = viewText
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
