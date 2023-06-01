module Lib.CoreEngine.GameComponents.Exit.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Exit.Display exposing (view)
import Lib.CoreEngine.GameComponents.Exit.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for exit
init : the init function for exit
update : the update function for exit
view : the view function for exit
query : exit does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "exit"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
