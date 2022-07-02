module Lib.CoreEngine.GameComponent.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Dict exposing (Dict)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.DefinedTypes.Base exposing (DefinedTypes)



--- Component Base


type alias GameComponent =
    { name : String
    , kb_input : Bool
    , data : Data
    , init : Int -> GameComponentTMsg -> Data
    , update : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, GameComponentTMsg, GameGlobalData )
    , view : ( Data, Int ) -> GameGlobalData -> GlobalData -> Renderable
    , query : String -> ( Data, Int ) -> GameComponentTMsg
    }


type GameComponentTMsg
    = GameComponentStringMsg String
    | GameComponentIntMsg Int
    | GameComponentLStringMsg (List String)
    | GameComponentLSStringMsg String (List String)
    | NullGameComponentMsg


type alias Data =
    { status : LifeStatus
    , position : ( Int, Int ) -- The position in map
    , velocity : ( Float, Float )
    , acceleration : ( Float, Float )
    , simplecheck : Box -- Simple check the collision for faster calculation
    , collisionbox : List Box
    , extra : Dict String DefinedTypes
    }


type LifeStatus
    = Alive
    | Dead Int -- Record the death time


type alias Box =
    { offsetX : Int
    , offsetY : Int
    , width : Int
    , height : Int
    }
