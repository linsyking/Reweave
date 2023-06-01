module Components.Dialog.Text.Word.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Dialog.Text.Word.Word exposing (initWord, updateWord, viewWord)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for Word
init : the init function for Word
update : the update function for Word
view : the view function for Word
query : Word does not require query function
-}
component : Component
component =
    { name = "Word"
    , data = initWord 0 NullComponentMsg
    , init = initWord
    , update = updateWord
    , view = viewWord
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
