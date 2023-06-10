module Scenes.Path.Export exposing
    ( game
    , scene
    )

{-| This is the doc for this module

@docs game

@docs scene

-}

import Array
import Canvas exposing (group)
import Lib.CoreEngine.Export exposing (Data, genEngineScene, initEngine)
import Lib.Scene.Base exposing (Scene, SceneMsg(..), nullEngineT)
import Scenes.Path.Background exposing (background)
import Scenes.Path.Config exposing (allChartlets, initActors, initFrontGroundComponents, initGameGlobalData, initPlayer)


{-| game
-}
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
            , actors = initActors t engineMsg.collectedMonsters
            , chartlets = allChartlets
            , globalData =
                initGameGlobalData engineMsg.energy engineMsg.collectedMonsters engineMsg.ingameTime
            , background = ( Array.empty, background )
            , frontground = ( initFrontGroundComponents t engineMsg.collectedMonsters, \_ _ _ -> group [] [] )
            }
        )


{-| scene
-}
scene : Scene Data
scene =
    genEngineScene game
