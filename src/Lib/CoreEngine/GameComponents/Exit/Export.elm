module Lib.CoreEngine.GameComponents.Exit.Export exposing (..)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Exit.Display exposing (view)
import Lib.CoreEngine.GameComponents.Exit.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "exit"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
