module Lib.Scene.Base exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Lib.Audio.Base exposing (AudioOption)
import Lib.Component.Base exposing (Component)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition(..))
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth)


type alias Scene a =
    { init : Int -> SceneMsg -> a
    , update : Msg -> GlobalData -> ( a, Int ) -> ( a, SceneOutputMsg, GlobalData )
    , view : ( a, Int ) -> GlobalData -> Renderable
    }


nullScene : Scene Bool
nullScene =
    { init = \_ _ -> True
    , update = \_ gd ( x, _ ) -> ( x, NullSceneOutputMsg, gd )
    , view = \_ _ -> group [] []
    }


type SceneMsg
    = SceneStringMsg String
    | SceneIntMsg Int
    | SceneEngineMsg EngineInit
    | SceneEngineTMsg EngineT
    | NullSceneMsg


type SceneOutputMsg
    = SOChangeScene ( SceneMsg, String )
    | SOPlayAudio String String AudioOption
    | SOStopAudio String
    | SOSetVolume Float
    | NullSceneOutputMsg


type alias EngineInit =
    { player : GameComponent
    , actors : Array GameComponent
    , chartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
    , globalData : GameGlobalData
    , background : ( Array Component, Int -> GameGlobalData -> GlobalData -> Renderable )
    , frontground : ( Array Component, Int -> GameGlobalData -> GlobalData -> Renderable )
    }


type alias EngineT =
    { energy : Float
    , playerPosition : PlayerInitPosition
    , collectedMonsters : List String
    , specialstate : Int
    }


nullEngineT : EngineT
nullEngineT =
    { energy = 0
    , playerPosition = DefaultPlayerPosition
    , collectedMonsters = []
    , specialstate = 0
    }
