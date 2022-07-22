module Lib.CoreEngine.GameComponents.Goomba.Export exposing (..)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Goomba.Display exposing (view)
import Lib.CoreEngine.GameComponents.Goomba.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "goomba"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
