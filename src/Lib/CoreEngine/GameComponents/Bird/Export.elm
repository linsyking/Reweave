module Lib.CoreEngine.GameComponents.Bird.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Bird.Display exposing (view)
import Lib.CoreEngine.GameComponents.Bird.Model exposing (initData, initModel, updateModel)


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
