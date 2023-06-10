module Lib.Scene.Base exposing
    ( SceneMsg(..)
    , SceneOutputMsg(..)
    , Scene
    , EngineInit
    , EngineT
    , nullScene
    , nullEngineT
    )

{-| This is the doc for this module


# Scene

Scene plays an important role in our game engine.

It is like a "page". You can change scenes in the game.

Different levels are different scenes.

You have to transmit data to next scene if you don't store the data in globaldata.

@docs SceneMsg

@docs SceneOutputMsg

@docs Scene

@docs EngineInit

@docs EngineT

@docs nullScene

@docs nullEngineT

-}

import Array exposing (Array)
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Lib.Audio.Base exposing (AudioOption)
import Lib.Component.Base exposing (Component)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition(..))
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth)


{-| Scene
-}
type alias Scene a =
    { init : Int -> SceneMsg -> a
    , update : Msg -> GlobalData -> ( a, Int ) -> ( a, List SceneOutputMsg, GlobalData )
    , view : ( a, Int ) -> GlobalData -> Renderable
    }


{-| nullScene
-}
nullScene : Scene Bool
nullScene =
    { init = \_ _ -> True
    , update = \_ gd ( x, _ ) -> ( x, [], gd )
    , view = \_ _ -> group [] []
    }


{-| SceneMsg

The `SceneEngineMsg` is used to init the game engine.

-}
type SceneMsg
    = SceneStringMsg String
    | SceneIntMsg Int
    | SceneEngineMsg EngineInit
    | SceneEngineTMsg EngineT
    | NullSceneMsg


{-| SceneOutputMsg

When you want to change the scene or play the audio, you have to send those messages to the central controller.

-}
type SceneOutputMsg
    = SOChangeScene ( SceneMsg, String )
    | SOPlayAudio String String AudioOption
    | SOStopAudio String
    | SOSetVolume Float


{-| EngineInit

Init an engine.

-}
type alias EngineInit =
    { player : GameComponent
    , actors : Array GameComponent
    , chartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
    , globalData : GameGlobalData
    , background : ( Array Component, Int -> GameGlobalData -> GlobalData -> Renderable )
    , frontground : ( Array Component, Int -> GameGlobalData -> GlobalData -> Renderable )
    }


{-| EngineT

This is the message that can be transmitted between scenes.

-}
type alias EngineT =
    { energy : Float
    , playerPosition : PlayerInitPosition
    , collectedMonsters : List String
    , specialstate : Int
    , ingameTime : Int
    }


{-| nullEngineT
-}
nullEngineT : EngineT
nullEngineT =
    { energy = 500
    , playerPosition = DefaultPlayerPosition
    , collectedMonsters = []
    , specialstate = 0
    , ingameTime = 0
    }
