module Lib.CoreEngine.GameLayer.Export exposing
    ( Data
    , nullData
    , layer
    )

{-|


# Gamelayer

Game layer deals with game objects.

It deals with the collisons, interactions between objects.

There are two basic types of objects in our game engine.

In every frame, the actors will change their velocity (not position), and the gamelayer will check if their velocity is valid.

If the velocity is acceptable, it will be added to the position of the object. Otherwise it will be cancelled.


## Solid

Those are stored in the map.

They cannot move.

No objects can move into them (Even though they have high speed).

We have code in physics module that check this.


## Actors

Actors are objects that can move and interactive with other actors.

When an actor is hitting with another object, it will receive a gameintercollision message.

The message will tell those objects that they are colliding with each other.

If there is no special code in actor gc, one actor can go through another actor without collision detection.

Many gc that has life features a "die" interface.

If you send "die" to the goomba or player, it will die immediately.

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
