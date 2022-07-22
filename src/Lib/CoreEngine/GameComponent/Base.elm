module Lib.CoreEngine.GameComponent.Base exposing (..)

{-| This is the doc for this module

@docs GameComponentMsgType

@docs GameComponentTMsg

@docs LifeStatus

@docs GameComponent

@docs Data

@docs Box

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponents.Ball.Base exposing (BallInit)
import Lib.CoreEngine.GameComponents.Bone.Base exposing (BoneInit)
import Lib.CoreEngine.GameComponents.Bullet.Base exposing (BulletInit)
import Lib.CoreEngine.GameComponents.CutScene.Base exposing (CutSceneInit)
import Lib.CoreEngine.GameComponents.EnergyCrystal.Base exposing (EnergyCrystalInit)
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Fireball.Base exposing (FireballInit)
import Lib.CoreEngine.GameComponents.Fish.Base exposing (FishInit)
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.GoombaEmitter.Base exposing (GoombaEmitterInit)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit, PlayerInitPosition)
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeInit)
import Lib.CoreEngine.GameComponents.Turtle.Base exposing (TurtleInit)



--- Component Base


{-| GameComponent
-}
type alias GameComponent =
    { name : String
    , data : Data
    , init : Int -> GameComponentTMsg -> Data
    , update : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
    , view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
    }


{-| GameComponentMsgType
-}
type GameComponentMsgType
    = GameParentMsg GameComponentTMsg
    | GameActorUidMsg Int GameComponentTMsg
    | GameActorNameMsg String GameComponentTMsg


{-| GameComponentTMsg
-}
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
    | GameBulletInit BulletInit
    | GameFishInit FishInit
    | GameExitInit ExitInit
    | GameFireballInit FireballInit
    | GameTurtleInit TurtleInit
    | GameCutSceneInit CutSceneInit
    | GameExitScene String PlayerInitPosition Int
    | GameBoneInit BoneInit
    | GameEnergyCrystalInit EnergyCrystalInit
    | GameBallInit BallInit
    | GameStringIntMsg String Int
    | NullGameComponentMsg


{-| Data
-}
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


{-| LifeStatus
-}
type LifeStatus
    = Alive
    | Dead Int -- Record the death time


{-| Box
-}
type alias Box =
    { name : String
    , offsetX : Int
    , offsetY : Int
    , width : Int
    , height : Int
    }
