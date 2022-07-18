# coding=utf-8
'''
@Author: King
@Date: 2022-07-17 星期天 20-28-30
@Email: linsy_king@sjtu.edu.cn
@Url: http://www.yydbxx.cn
'''

from curses.ascii import isupper
import os

import sys

levelname = sys.argv[1]

if not isupper(levelname[0]):
    print('Not Valid Levelname')
    exit(0)

bg = '''module Scenes.$!.Background exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.Render.Render exposing (renderSprite)


background : Int -> GameGlobalData -> GlobalData -> Renderable
background _ _ gd =
    renderSprite gd [ alpha 0.3 ] ( 0, 0 ) ( 1920, 1080 ) "background"
'''.replace("$!", levelname)

config = '''module Scenes.$!.Config exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (initGameComponent)
import Lib.CoreEngine.GameComponents.Exit.Base exposing (ExitInit)
import Lib.CoreEngine.GameComponents.Exit.Export as Exit
import Lib.CoreEngine.GameComponents.Goomba.Base exposing (GoombaInit)
import Lib.CoreEngine.GameComponents.Goomba.Export as Goomba
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInit)
import Lib.CoreEngine.GameComponents.Player.Export as Player
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..), SpikeInit)
import Lib.CoreEngine.GameComponents.Spike.Export as Spike
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.Scene.Base exposing (PlayerInitPosition(..))
import Scenes.$!.Map exposing (mymap)


initFrontGroundComponents : Int -> Array Component
initFrontGroundComponents _ =
    Array.fromList
        []


initPlayer : Int -> PlayerInitPosition -> GameComponent
initPlayer t pos =
    case pos of
        DefaultPlayerPosition ->
            initGameComponent t (GamePlayerInit (PlayerInit ( 50, 2000 ))) Player.gameComponent

        CustomPlayerPosition x ->
            initGameComponent t (GamePlayerInit (PlayerInit x)) Player.gameComponent


initActors : Int -> Array GameComponent
initActors t =
    Array.fromList
        [ initGameComponent t (GameGoombaInit (GoombaInit ( 1200, 1800 ) ( 0, 0 ) 4)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 1000, 1800 ) ( 0, 0 ) 5)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 2000, 800 ) ( 0, 0 ) 2)) Goomba.gameComponent
        , initGameComponent t (GameGoombaInit (GoombaInit ( 3500, 500 ) ( 0, 0 ) 3)) Goomba.gameComponent
        , initGameComponent t (GameExitInit (ExitInit ( 3800, 1600 ) ( 10, 160 ) "Scene1" 9)) Exit.gameComponent
        , initGameComponent t (GameSpikeInit (SpikeInit ( 864, 2016 ) HorDown 15 12)) Spike.gameComponent
        ]


initCamera : CameraData
initCamera =
    CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 32, 0 ), ( 32 * 119 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )


initGameGlobalData : Float -> GameGlobalData
initGameGlobalData e =
    { camera = initCamera
    , solidmap = mymap
    , mapsize = ( 120, 70 )
    , selectobj = 1
    , energy = e
    , ingamepause = False
    , currentScene = "$!"
    }


allChartlets : List ( GlobalData -> GameGlobalData -> Renderable, GameLayerDepth )
allChartlets =
    []
'''.replace("$!", levelname)

export = '''module Scenes.$!.Export exposing (..)

import Array
import Canvas exposing (group)
import Lib.CoreEngine.Export exposing (Data, genEngineScene, initEngine)
import Lib.Scene.Base exposing (Scene, SceneMsg(..), nullEngineT)
import Scenes.$!.Background exposing (background)
import Scenes.$!.Config exposing (allChartlets, initActors, initFrontGroundComponents, initGameGlobalData, initPlayer)


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
            , background = ( Array.empty, background )
            , frontground = ( initFrontGroundComponents t, \_ _ _ -> group [] [] )
            }
        )


scene : Scene Data
scene =
    genEngineScene game
'''.replace("$!", levelname)

map = '''module Scenes.$!.Map exposing (..)

import Array2D
import Lib.Map.Poly exposing (buildrect)


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


mymap : Array2D.Array2D Int
mymap =
    sds
        |> buildrect ( 0, 0 ) ( 1, 70 ) 1
'''.replace("$!", levelname)


with open('./src/Scenes/AllScenes.elm', 'r') as f:
    als = f.readlines()

als.insert(2, f"import Scenes.{levelname}.Export as {levelname}\n")
als = "".join(als)
als = als.replace(
    "    ]", f"    , ( \"{levelname}\", CEG.toCT {levelname}.scene )\n    ]")


os.mkdir(f'./src/Scenes/{levelname}')

with open(f'./src/Scenes/{levelname}/Background.elm', 'w') as f:
    f.write(bg)

with open(f'./src/Scenes/{levelname}/Config.elm', 'w') as f:
    f.write(config)

with open(f'./src/Scenes/{levelname}/Map.elm', 'w') as f:
    f.write(map)

with open(f'./src/Scenes/{levelname}/Export.elm', 'w') as f:
    f.write(export)

with open(f'./src/Scenes/AllScenes.elm', 'w') as f:
    f.write(als)
