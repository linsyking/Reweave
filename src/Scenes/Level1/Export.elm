module Scenes.Level1.Export exposing (..)

import Canvas exposing (group)
import Lib.CoreEngine.Export exposing (Data, genEngineScene, initEngine)
import Lib.Scene.Base exposing (Scene, SceneMsg(..))
import Scenes.Level1.Background exposing (background)
import Scenes.Level1.Config exposing (allChartlets, initActors, initGameGlobalData, initPlayer)


game : Int -> SceneMsg -> Data
game t sm =
    initEngine t
        (SceneEngineMsg
            { player = initPlayer
            , actors = initActors
            , chartlets = allChartlets
            , globalData =
                initGameGlobalData
                    (case sm of
                        SceneEngineTMsg et ->
                            et.energy

                        _ ->
                            0
                    )
            , background = background
            , frontground = \_ _ _ -> group [] []
            }
        )


scene : Scene Data
scene =
    genEngineScene game
