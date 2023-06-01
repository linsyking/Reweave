module Lib.CoreEngine.GameLayer.Common exposing
    ( Model
    , searchNameGC
    , searchUIDGC
    , kineticCalc
    , addenergy
    , getDSEnergy
    , calcRPer
    )

{-| This is the doc for this module

@docs Model

@docs searchNameGC

@docs searchUIDGC

@docs kineticCalc

@docs addenergy

@docs getDSEnergy

@docs calcRPer

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

Search gc by name.

-}
searchNameGC : String -> Array.Array GameComponent -> List Int
searchNameGC s gcs =
    locate (\x -> x.name == s) gcs


{-| searchUIDGC

Search gc by UID.

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

    else if ori + del <= 0 then
        0

    else
        ori + del


{-| getDSEnergy
-}
getDSEnergy : ( Float, Float ) -> ( Float, Float ) -> GlobalData -> GameGlobalData -> ( Float, GameGlobalData )
getDSEnergy p m gd ggd =
    let
        curenergy =
            ggd.energy

        pc =
            calcRPer p m gd

        gpc =
            curenergy * pc
    in
    if pc < 0.2 then
        ( 0, ggd )

    else if pc >= 1 then
        ( curenergy, { ggd | energy = 0 } )

    else
        ( gpc, { ggd | energy = curenergy - gpc } )


{-| calcDRate
-}
calcDRate : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float ) -> Float
calcDRate p1 p2 ( w, h ) =
    let
        ( p1X, p1Y ) =
            p1

        ( p2X, p2Y ) =
            p2

        k =
            (p2X - p1X) / (p2Y - p1Y)

        k1 =
            p1X / (p1Y - h)

        k2 =
            (w - p1X) / (h - p1Y)

        k3 =
            p1X / p1Y

        k4 =
            (p1X - w) / p1Y
    in
    if p2Y > p1Y && k >= k1 && k <= k2 then
        1 - (h - p2Y) / (h - p1Y)

    else if p2Y < p1Y && k >= k4 && k <= k3 then
        1 - p2Y / p1Y

    else if p2X < p1X && (k < k1 || k > k3) then
        1 - p2X / p1X

    else if p2X > p1X && (k < k4 || k > k2) then
        1 - (w - p2X) / (w - p1X)

    else if p1Y == p2Y && p2X > p1X then
        (p2X - p1X) / (w - p1X)

    else if p1Y == p2Y && p2X < p1X then
        (p1X - p2X) / p1X

    else
        0


{-| calcRPer
-}
calcRPer : ( Float, Float ) -> ( Float, Float ) -> GlobalData -> Float
calcRPer ( px, py ) ( mx, my ) gd =
    let
        ds =
            calcDRate ( px, py ) ( mx, my ) ( toFloat gd.realWidth, toFloat gd.realHeight )
    in
    if ds > 0.9 then
        1

    else
        ds
