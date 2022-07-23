module Lib.CoreEngine.GameComponents.Monster.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Monster.Display exposing (view)
import Lib.CoreEngine.GameComponents.Monster.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "bird"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
