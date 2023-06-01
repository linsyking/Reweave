module Lib.CoreEngine.Global exposing
    ( sdata
    , dtToT
    , toCT
    )

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

Change the scene customized data to SceneDataTypes

-}
sdata : Data -> SceneDataTypes
sdata d =
    CoreEngineDataT d


{-| dtToT

Change back to the scene data.

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

Change the scene data to the SceneCT data.

-}
toCT : Scene Data -> SceneCT
toCT sd =
    let
        init : Int -> SceneMsg -> SceneDataTypes
        init t tm =
            sdata (sd.init t tm)

        update : Msg -> GlobalData -> ( SceneDataTypes, Int ) -> ( SceneDataTypes, List SceneOutputMsg, GlobalData )
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
