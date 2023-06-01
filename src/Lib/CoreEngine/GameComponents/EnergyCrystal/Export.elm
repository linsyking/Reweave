module Lib.CoreEngine.GameComponents.EnergyCrystal.Export exposing (gameComponent)

{-| This is the doc for this module

@docs gameComponent

-}

import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Display exposing (view)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Model exposing (initData, initModel, updateModel)


{-| gameComponent
name : gameComponent Type
data : the model for energyCrystal
init : the init function for energyCrystal
update : the update function for energyCrystal
view : the view function for energyCrystal
query : energyCrystal does not require query function
-}
gameComponent : GameComponent
gameComponent =
    { name = "energyCrystal"
    , data = initData
    , init = initModel
    , update = updateModel
    , view = view
    }
