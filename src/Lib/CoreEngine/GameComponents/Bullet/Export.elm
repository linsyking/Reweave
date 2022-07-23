module Lib.CoreEngine.GameComponents.Bullet.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Bullet.Display exposing (view)
import Lib.CoreEngine.GameComponents.Bullet.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "bullet"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
