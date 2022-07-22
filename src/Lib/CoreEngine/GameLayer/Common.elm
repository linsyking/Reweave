module Lib.CoreEngine.GameLayer.Common exposing
    ( Model
    , searchNameGC
    , searchUIDGC
    , kineticCalc
    , addenergy
    )

{-| This is the doc for this module

@docs Model

@docs searchNameGC

@docs searchUIDGC

@docs kineticCalc

@docs addenergy

-}

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth)
import Lib.Tools.Array exposing (locate)


{-| Model
-}
type alias Model =
    { player : GameComponent
    , actors : Array GameComponent
    , chartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
    , lastuseEnergyTime : Int
    , ignoreInput : Bool
    }


{-| searchNameGC
-}
searchNameGC : String -> Array.Array GameComponent -> List Int
searchNameGC s gcs =
    locate (\x -> x.name == s) gcs


{-| searchUIDGC
-}
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


{-| kineticCalc
-}
kineticCalc : Int -> ( Float, Float ) -> Float
kineticCalc mass ( vx, vy ) =
    toFloat mass * (vx * vx + vy * vy) / 10000


{-| addenergy
-}
addenergy : Float -> Float -> Float
addenergy ori del =
    if ori + del >= 2000 then
        2000

    else
        ori + del
