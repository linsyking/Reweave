module Lib.CoreEngine.GameComponent.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeInit)



--- Component Base


type alias GameComponent =
    { name : String
    , data : Data
    , init : Int -> GameComponentTMsg -> Data
    , update : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
    , view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
    }


type GameComponentMsgType
    = GameParentMsg GameComponentTMsg
    | GameActorUidMsg Int GameComponentTMsg
    | GameActorNameMsg String GameComponentTMsg


type GameComponentTMsg
    = GameSolidCollisionMsg (List ( Int, Int ))
    | GameInterCollisionMsg String Data (List Box)
    | GameClearVelocity
    | GameUseEnergy ( Float, Float ) Float
    | GameStringMsg String
    | GamePlayerInit PlayerInit
    | GameGoombaInit GoombaInit
    | GameGoombaEmitterInit GoombaEmitterInit
    | GameSpikeInit SpikeInit
    | GameExitInit ExitInit
    | GameExitScene String
    | NullGameComponentMsg


type alias Data =
    { status : LifeStatus
    , uid : Int
    , position : ( Int, Int ) -- The position in map
    , velocity : ( Float, Float )
    , mass : Int
    , acceleration : ( Float, Float )
    , simplecheck : Box -- Simple check the collision for faster calculation
    , collisionbox : List Box
    , extra : Dict String DefinedTypes
    }


type LifeStatus
    = Alive
    | Dead Int -- Record the death time


type alias Box =
    { name : String
    , offsetX : Int
    , offsetY : Int
    , width : Int
    , height : Int
    }
