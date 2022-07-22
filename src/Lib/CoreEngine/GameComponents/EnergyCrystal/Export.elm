module Lib.CoreEngine.GameComponents.EnergyCrystal.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Display exposing (view)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Model exposing (initData, initModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "energyCrystal"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
