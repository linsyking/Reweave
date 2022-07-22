module Lib.CoreEngine.GameComponents.Player.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Display exposing (view)
import Lib.CoreEngine.GameComponents.Player.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "player"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
