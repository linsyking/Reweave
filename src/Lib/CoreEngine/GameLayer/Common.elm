module Lib.CoreEngine.GameLayer.Common exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth)
import Lib.Tools.Array exposing (locate)


type alias Model =
    { player : GameComponent
    , actors : Array GameComponent
    , chartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
    , lastuseEnergyTime : Int
    , ignoreInput : Bool
    }


searchNameGC : String -> Array.Array GameComponent -> List Int
searchNameGC s gcs =
    locate (\x -> x.name == s) gcs


searchUIDGC : Int -> Array.Array GameComponent -> Int
searchUIDGC s gcs =
    let
        res =
            locate (\x -> x.data.uid == s) gcs
    in
    case res of
        [ x ] ->
            x

        _ ->
            -1


kineticCalc : Int -> ( Float, Float ) -> Float
kineticCalc mass ( vx, vy ) =
    toFloat mass * (vx * vx + vy * vy) / 10000
