module Lib.CoreEngine.GameComponents.CutScene.Export exposing (..)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.CutScene.Display exposing (view)
import Lib.CoreEngine.GameComponents.CutScene.Model exposing (initData, initModel, updateModel)


{-| gameComponent
-}
gameComponent : GameComponent
gameComponent =
    { name = "CutScene"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
