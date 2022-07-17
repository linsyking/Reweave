module Lib.CoreEngine.GameComponents.GoombaEmitter.Export exposing (..)

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Display exposing (view)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Model exposing (initData, initModel, queryModel, updateModel)


gameComponent : GameComponent
gameComponent =
    { name = "goombaemitter"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    , query = queryModel
    }
