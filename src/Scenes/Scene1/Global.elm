module Scenes.Scene1.Global exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Scene.Base exposing (..)
import Scenes.Scene1.Export exposing (..)
import Scenes.SceneSettings exposing (..)



--- Global environment: Can use Common
--- In this file, we have to convert our own designed scene to SceneCT


sdata : Data -> SceneDataTypes
sdata d =
    S1DataT d


dtToT : SceneDataTypes -> Data
dtToT dt =
    case dt of
        S1DataT x ->
            x

        _ ->
            nullData



--- Only modify variables above


toCT : Scene Data -> SceneCT
toCT sd =
    let
        init : Int -> SceneMsg -> SceneDataTypes
        init t tm =
            sdata (sd.init t tm)

        update : Msg -> ( SceneDataTypes, Int ) -> ( SceneDataTypes, SceneOutputMsg )
        update msg ( dt, t ) =
            let
                ( sdt, som ) =
                    sd.update msg ( dtToT dt, t )
            in
            ( sdata sdt, som )

        view : ( SceneDataTypes, Int ) -> GlobalData -> Renderable
        view ( dt, t ) vp =
            sd.view ( dtToT dt, t ) vp
    in
    { init = init
    , update = update
    , view = view
    }
