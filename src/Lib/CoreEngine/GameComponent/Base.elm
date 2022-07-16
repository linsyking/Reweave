module Lib.CoreEngine.GameComponent.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes)
import Lib.CoreEngine.Base exposing (GameGlobalData)



--- Component Base


type alias GameComponent =
    { name : String
    , data : Data
    , init : Int -> GameComponentTMsg -> Data
    , update : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
    , view : ( Data, Int ) -> GameGlobalData -> GlobalData -> Renderable
    , query : String -> ( Data, Int ) -> GameComponentTMsg
    }


type GameComponentMsgType
    = GameParentMsg GameComponentTMsg
    | GameActorUidMsg Int GameComponentTMsg
    | GameActorNameMsg String GameComponentTMsg


type GameComponentTMsg
    = GameSolidCollisionMsg (List ( Int, Int ))
    | GameInterCollisionMsg String Int ( Int, Int ) (List Box)
    | GameClearVelocity
    | GameUseEnergy ( Float, Float ) Float
    | GameStringMsg String
    | GamePlayerInit PlayerInit
    | GameGoombaInit GoombaInit
    | GameExitInit ExitInit
    | NullGameComponentMsg


type alias PlayerInit =
    { initPosition : ( Int, Int )
    }


type alias GoombaInit =
    { initPosition : ( Int, Int )
    , initVelocity : ( Float, Float )
    , uid : Int
    }


type alias ExitInit =
    { initPosition : ( Int, Int )
    , togo : String
    , uid : Int
    }


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
