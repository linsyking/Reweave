module Components.Dialog.NextButton.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Dialog.NextButton.NextButton exposing (initButton, updateButton, viewButton)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
-}
component : Component
component =
    { name = "NextButton"
    , data = initButton 0 NullComponentMsg
    , init = initButton
    , update = updateButton
    , view = viewButton
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
