module Lib.CoreEngine.Base exposing (..)


type alias GameGlobalData =
    { cameraPosition : ( Int, Int )
    }


nullGameGlobalData : GameGlobalData
nullGameGlobalData =
    { cameraPosition = ( 0, 0 )
    }
