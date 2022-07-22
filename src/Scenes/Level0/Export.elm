module Scenes.Level0.Export exposing (..)

import Array
import Canvas exposing (group)
import Lib.CoreEngine.Export exposing (Data, genEngineScene, initEngine)
import Lib.Scene.Base exposing (Scene, SceneMsg(..), nullEngineT)
import Scenes.Level0.Background exposing (background)
import Scenes.Level0.Config exposing (allChartlets, initActors, initFrontGroundComponents, initGameGlobalData, initPlayer)


game : Int -> SceneMsg -> Data
game t sm =
    let
        engineMsg =
            case sm of
                SceneEngineTMsg x ->
                    x

                _ ->
                    nullEngineT
    in
    initEngine t
        (SceneEngineMsg
            { player = initPlayer t engineMsg.playerPosition
            , actors = initActors t engineMsg.specialstate
            , chartlets = allChartlets engineMsg.specialstate
            , globalData =
                initGameGlobalData engineMsg.energy engineMsg.collectedMonsters engineMsg.specialstate
            , background = ( Array.empty, background )
            , frontground = ( initFrontGroundComponents t engineMsg.specialstate, \_ _ _ -> group [] [] )
            }
        )


scene : Scene Data
scene =
    genEngineScene game
