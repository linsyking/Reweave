module Lib.CoreEngine.GameComponents.Ball.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Ball.Display exposing (view)
import Lib.CoreEngine.GameComponents.Ball.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "fireball"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
