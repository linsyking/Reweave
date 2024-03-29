module Lib.Layer.Base exposing
    ( LayerMsg(..)
    , LayerTarget(..)
    , Layer
    , GameLayerInit
    )

{-| This is the doc for this module

Layer plays a very important role in our game.

It is mainly used to seperate different rendering layers.

Using layers can help us deal with different things in different layers.

@docs LayerMsg

@docs LayerTarget

@docs Layer

@docs GameLayerInit

-}

import Array exposing (Array)
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Audio.Base exposing (AudioOption)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.FrontgroundLayer.Base exposing (CTInfo)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth)
import Lib.Scene.Base exposing (EngineT)


{-| Layer
-}
type alias Layer a b =
    --- b is the layer data, a is the common data that shares between layers
    { data : b
    , init : Int -> LayerMsg -> a -> b
    , update : Msg -> GlobalData -> LayerMsg -> ( b, Int ) -> a -> ( ( b, a, List ( LayerTarget, LayerMsg ) ), GlobalData )
    , view : ( b, Int ) -> a -> GlobalData -> Renderable
    }


{-| LayerMsg
-}
type LayerMsg
    = LayerStringMsg String
    | LayerIntMsg Int
    | LayerSoundMsg String String AudioOption
    | LayerStopSoundMsg String
    | LayerInitGameLayer GameLayerInit
    | LayerCTMsg CTInfo
    | LayerExitMsg EngineT String Int
    | LayerRestartMsg Int
    | LayerInfoPositionMsg String ( Int, Int )
    | NullLayerMsg


{-| GameLayerInit
-}
type alias GameLayerInit =
    { player : GameComponent
    , actors : Array GameComponent
    , chartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
    }


{-| LayerTarget
-}
type LayerTarget
    = LayerParentScene
    | LayerName String



--- LayerMsg is the message that sends to outer layer (scene)
