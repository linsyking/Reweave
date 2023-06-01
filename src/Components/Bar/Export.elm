module Components.Bar.Export exposing
    ( component
    , initComponent
    )

{-| This is the doc for this module

Energy Bar

@docs component

@docs initComponent

-}

import Components.Bar.Bar exposing (initBar, updateBar, viewBar)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))


{-| component
name : Component Type
data : the model for bar
init : the init function for bar
update : the update function for bar
view : the view function for bar
query : bar does not require query function
-}
component : Component
component =
    { name = "Bar"
    , data = initBar 0 NullComponentMsg
    , init = initBar
    , update = updateBar
    , view = viewBar
    , query = \_ _ -> NullComponentMsg
    }


{-| initComponent
-}
initComponent : Int -> ComponentTMsg -> Component
initComponent t ct =
    { component | data = component.init t ct }
