module Scenes.Home.Global exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Scene.Base exposing (..)
import Scenes.Home.Export exposing (..)
import Scenes.SceneSettings exposing (..)


sdata : Data -> SceneDataTypes
sdata d =
    HDataT d


dtToT : SceneDataTypes -> Data
dtToT dt =
    case dt of
        HDataT x ->
            x

        _ ->
            nullData


toCT : Scene Data -> SceneCT
toCT sd =
    let
        init : Int -> SceneMsg -> SceneDataTypes
        init t tm =
            sdata (sd.init t tm)

        update : Msg -> GlobalData -> ( SceneDataTypes, Int ) -> ( SceneDataTypes, SceneOutputMsg, GlobalData )
        update msg gd ( dt, t ) =
            let
                ( sdt, som, newgd ) =
                    sd.update msg gd ( dtToT dt, t )
            in
            ( sdata sdt, som, newgd )

        view : ( SceneDataTypes, Int ) -> GlobalData -> Renderable
        view ( dt, t ) vp =
            sd.view ( dtToT dt, t ) vp
    in
    { init = init
    , update = update
    , view = view
    }
