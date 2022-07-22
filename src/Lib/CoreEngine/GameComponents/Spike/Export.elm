module Lib.CoreEngine.GameComponents.Spike.Export exposing (..)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Spike.Display exposing (view)
import Lib.CoreEngine.GameComponents.Spike.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "spike"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
