module Lib.CoreEngine.Base exposing (..)

import Array
import Array2D exposing (Array2D)


type alias GameGlobalData =
    { cameraPosition : ( Int, Int )
    , solidmap : Array2D Int
    , mapsize : ( Int, Int )
    }


nullGameGlobalData : GameGlobalData
nullGameGlobalData =
    { cameraPosition = ( 0, 0 )
    , solidmap = Array2D.empty
    , mapsize = ( 0, 0 )
    }


testGameGlobalData : GameGlobalData
testGameGlobalData =
    { cameraPosition = ( 0, 0 )
    , solidmap = ps
    , mapsize = ( 240, 137 )
    }


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 240 135 0


ps : Array2D.Array2D Int
ps =
    Array2D.appendColumn Array.empty 1 (Array2D.appendColumn Array.empty 1 sds)
