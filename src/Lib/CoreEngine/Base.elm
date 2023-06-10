module Lib.CoreEngine.Base exposing
    ( GameGlobalData
    , brickSize
    , nullGameGlobalData
    , testGameGlobalData
    )

{-| This is the doc for this module


# Core Engine

Please go to `Lib.CoreEngine.Common` to see details

@docs GameGlobalData

@docs brickSize

@docs nullGameGlobalData

@docs testGameGlobalData

-}

import Array2D exposing (Array2D)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.Map.Poly exposing (buildrect)


{-| GameGlobalData

This is the data every layer can read and write.

We don't want too many game objects to be exposed here.

-}
type alias GameGlobalData =
    { camera : CameraData
    , solidmap : Array2D Int
    , mapsize : ( Int, Int )
    , selectobj : Int
    , energy : Float
    , ingamepause : Bool
    , settingpause : Bool
    , currentScene : String
    , collectedMonsters : List String
    , specialState : Int
    , ingameTime : Int
    }


{-| brickSize

The pixel size for a brick.

32 is a perfect choice.

-}
brickSize : Int
brickSize =
    32


{-| nullGameGlobalData
-}
nullGameGlobalData : GameGlobalData
nullGameGlobalData =
    { camera = CameraData ( 0, 0 ) ( 0, 0 ) ( ( 0, 0 ), ( 0, 0 ) ) ( ( 0, 0 ), ( 0, 0 ) )
    , solidmap = Array2D.empty
    , mapsize = ( 0, 0 )
    , selectobj = 1
    , energy = 0
    , ingamepause = False
    , currentScene = ""
    , collectedMonsters = []
    , settingpause = False
    , specialState = 0
    , ingameTime = 0
    }


{-| testGameGlobalData
-}
testGameGlobalData : GameGlobalData
testGameGlobalData =
    { camera = CameraData ( 0, 1120 ) ( 0, 0 ) ( ( 0, 0 ), ( 32 * 120 - 1, 70 * 32 - 1 ) ) ( ( 0.2, 0.3 ), ( 0.4, 0.4 ) )
    , solidmap = ps
    , mapsize = ( 120, 70 )
    , selectobj = -1
    , energy = 0
    , ingamepause = False
    , currentScene = "Level1"
    , collectedMonsters = []
    , settingpause = False
    , specialState = 0
    , ingameTime = 0
    }


{-| sds
-}
sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


{-| ps
-}
ps : Array2D.Array2D Int
ps =
    sds
        |> buildrect ( 0, 36 ) ( 1, 34 ) 1
        |> buildrect ( 20, 64 ) ( 3, 3 ) 1
        |> buildrect ( 25, 61 ) ( 3, 3 ) 1
        |> buildrect ( 29, 58 ) ( 3, 3 ) 1
        |> buildrect ( 35, 54 ) ( 3, 3 ) 1
        |> buildrect ( 39, 50 ) ( 3, 3 ) 1
        |> buildrect ( 43, 46 ) ( 3, 3 ) 1
        |> buildrect ( 40, 37 ) ( 3, 3 ) 1
        |> buildrect ( 49, 43 ) ( 3, 3 ) 1
        |> buildrect ( 53, 40 ) ( 3, 3 ) 1
        |> buildrect ( 60, 50 ) ( 13, 3 ) 1
        |> buildrect ( 0, 68 ) ( 120, 2 ) 1
        |> buildrect ( 0, 0 ) ( 120, 2 ) 1
