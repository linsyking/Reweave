module Lib.CoreEngine.Global exposing (..)

{-| This is the doc for this module

@docs sdata

@docs dtToT

@docs toCT

-}

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Export exposing (Data, nullData)
import Lib.Scene.Base exposing (Scene, SceneMsg, SceneOutputMsg)
import Scenes.SceneSettings exposing (SceneCT, SceneDataTypes(..))


{-| sdata
-}
sdata : Data -> SceneDataTypes
sdata d =
    CoreEngineDataT d


{-| dtToT
-}
dtToT : SceneDataTypes -> Data
dtToT dt =
    case dt of
        CoreEngineDataT x ->
            x

        _ ->
            nullData



--- Only modify variables above


{-| toCT
-}
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
