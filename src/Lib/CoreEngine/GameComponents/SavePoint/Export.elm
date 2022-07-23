module Lib.CoreEngine.GameComponents.SavePoint.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.SavePoint.Display exposing (view)
import Lib.CoreEngine.GameComponents.SavePoint.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "SavePoint"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
