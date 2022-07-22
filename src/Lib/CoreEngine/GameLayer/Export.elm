module Lib.CoreEngine.GameLayer.Export exposing (..)

{-| This is the doc for this module

@docs Data

@docs nullData

@docs layer

-}

import Array
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.CoreEngine.GameLayer.Display exposing (view)
import Lib.CoreEngine.GameLayer.Model exposing (initModel, updateModel)
import Lib.Layer.Base exposing (Layer)


{-| Data
-}
type alias Data =
    Model


{-| nullData
-}
nullData : Data
nullData =
    { player = Player.gameComponent, actors = Array.empty, chartlets = [], lastuseEnergyTime = 0, ignoreInput = False }


{-| layer
-}
layer : Layer GameGlobalData Data
layer =
    { data = nullData
    , init = initModel
    , update = updateModel
    , view = view
    }
