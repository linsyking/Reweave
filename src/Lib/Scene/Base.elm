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
    , update : Msg -> GlobalData -> ( a, Int ) -> ( a, SceneOutputMsg, GlobalData )
    , view : ( a, Int ) -> GlobalData -> Renderable
    }


{-| nullScene
-}
nullScene : Scene Bool
nullScene =
    { init = \_ _ -> True
    , update = \_ gd ( x, _ ) -> ( x, NullSceneOutputMsg, gd )
    , view = \_ _ -> group [] []
    }


{-| SceneMsg
-}
type SceneMsg
    = SceneStringMsg String
    | SceneIntMsg Int
    | SceneEngineMsg EngineInit
    | SceneEngineTMsg EngineT
    | NullSceneMsg


{-| SceneOutputMsg
-}
type SceneOutputMsg
    = SOChangeScene ( SceneMsg, String )
    | SOPlayAudio String String AudioOption
    | SOStopAudio String
    | SOSetVolume Float
    | NullSceneOutputMsg


{-| EngineInit
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
-}
type alias EngineT =
    { energy : Float
    , playerPosition : PlayerInitPosition
    , collectedMonsters : List String
    , specialstate : Int
    }


{-| nullEngineT
-}
nullEngineT : EngineT
nullEngineT =
    { energy = 500
    , playerPosition = DefaultPlayerPosition
    , collectedMonsters = []
    , specialstate = 0
    }
