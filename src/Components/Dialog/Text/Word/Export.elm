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
