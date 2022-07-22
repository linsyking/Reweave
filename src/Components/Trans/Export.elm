module Components.Trans.Export exposing (..)

{-| This is the doc for this module

@docs component

@docs initComponent

-}

import Components.Trans.Trans exposing (initTrans, updateTrans, viewTrans)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
-}
component : Component
component =
    { name = "Trans"
    , data = initTrans 0 NullComponentMsg
    , init = initTrans
    , update = updateTrans
    , view = viewTrans
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
