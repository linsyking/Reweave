module Lib.CoreEngine.GameComponents.EnergyCrystal.Export exposing (..)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Display exposing (view)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "energyCrystal"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
