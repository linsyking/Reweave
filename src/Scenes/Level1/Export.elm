module Scenes.Level1.Export exposing (..)

import Canvas exposing (group)
import Lib.CoreEngine.Export exposing (Data, genEngineScene, initEngine)
import Lib.Scene.Base exposing (Scene, SceneMsg(..), nullEngineT)
import Scenes.Level1.Background exposing (background)
import Scenes.Level1.Config exposing (allChartlets, initActors, initGameGlobalData, initPlayer)


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
            , actors = initActors t
            , chartlets = allChartlets
            , globalData =
                initGameGlobalData engineMsg.energy
            , background = background
            , frontground = \_ _ _ -> group [] []
            }
        )


scene : Scene Data
scene =
    genEngineScene game
