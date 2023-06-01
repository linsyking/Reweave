module Lib.CoreEngine.GameComponents.CutScene.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.CutScene.Display exposing (view)
import Lib.CoreEngine.GameComponents.CutScene.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for CutScene
init : the init function for CutScene
update : the update function for CutScene
view : the view function for CutScene
query : CutScene does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "CutScene"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
