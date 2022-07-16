module Lib.Layer.Base exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Audio.Base exposing (AudioOption)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth)


type alias Layer a b =
    --- b is the layer data, a is the common data that shares between layers
    { data : b
    , init : Int -> LayerMsg -> a -> b
    , update : Msg -> GlobalData -> LayerMsg -> ( b, Int ) -> a -> ( ( b, a, List ( LayerTarget, LayerMsg ) ), GlobalData )
    , view : ( b, Int ) -> a -> GlobalData -> Renderable
    }


type LayerMsg
    = LayerStringMsg String
    | LayerIntMsg Int
    | LayerSoundMsg String String AudioOption
    | LayerStopSoundMsg String
    | LayerInitGameLayer GameLayerInit
    | LayerTimeSeries (Int -> GameGlobalData -> GlobalData -> Renderable)
    | NullLayerMsg


type alias GameLayerInit =
    { player : GameComponent
    , actors : Array GameComponent
    , chartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
    }


type LayerTarget
    = LayerParentScene
    | LayerName String
    | NullLayerTarget



--- LayerMsg is the message that sends to outer layer (scene)
