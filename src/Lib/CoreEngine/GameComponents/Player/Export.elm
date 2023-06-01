module Lib.CoreEngine.GameComponents.Player.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Display exposing (view)
import Lib.CoreEngine.GameComponents.Player.Model exposing (initData, initModel, updateModel)


{-| gameComponent

name : gameComponent Type
data : the model for player
init : the init function for player
update : the update function for player
view : the view function for player
query : player does not require query function

-}
gameComponent : GameComponent
gameComponent =
    { name = "player"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
