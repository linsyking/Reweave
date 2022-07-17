module Lib.CoreEngine.GameComponents.Bullet.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Bullet.Display exposing (view)
import Lib.CoreEngine.GameComponents.Bullet.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "bullet"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }