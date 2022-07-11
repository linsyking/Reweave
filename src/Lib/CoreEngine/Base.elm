module Lib.CoreEngine.Base exposing (..)

import Array2D exposing (Array2D)
import Lib.CoreEngine.Camera.Base exposing (CameraData)


type alias GameGlobalData =
    { camera : CameraData
    , solidmap : Array2D Int
    , mapsize : ( Int, Int )
    , selectobj : Int
    , energy : Float
    }


brickSize : Int
brickSize =
    32


nullGameGlobalData : GameGlobalData
nullGameGlobalData =
    { camera = CameraData ( 0, 0 ) ( 0, 0 )
    , solidmap = Array2D.empty
    , mapsize = ( 0, 0 )
    , selectobj = -1
    , energy = 0
    }


testGameGlobalData : GameGlobalData
testGameGlobalData =
    { camera = CameraData ( 0, 1120 ) ( 0, 0 )
    , solidmap = ps
    , mapsize = ( 120, 70 )
    , selectobj = -1
    , energy = 0
    }


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 120 70 0


ps : Array2D.Array2D Int
ps =
    sds
        |> buildrect ( 0, 36 ) ( 1, 34 )
        |> buildrect ( 20, 64 ) ( 3, 3 )
        |> buildrect ( 25, 61 ) ( 3, 3 )
        |> buildrect ( 29, 58 ) ( 3, 3 )
        |> buildrect ( 35, 54 ) ( 3, 3 )
        |> buildrect ( 39, 50 ) ( 3, 3 )
        |> buildrect ( 43, 46 ) ( 3, 3 )
        |> buildrect ( 40, 37 ) ( 3, 3 )
        |> buildrect ( 49, 43 ) ( 3, 3 )
        |> buildrect ( 53, 40 ) ( 3, 3 )
        |> buildrect ( 60, 50 ) ( 13, 3 )
        |> buildrect ( 0, 68 ) ( 120, 2 )
        |> buildrect ( 0, 0 ) ( 120, 2 )



-- |> buildrect ( 0, 35 ) ( 29, 1 )


buildrect : ( Int, Int ) -> ( Int, Int ) -> Array2D.Array2D Int -> Array2D.Array2D Int
buildrect ( x, y ) ( w, h ) ss =
    let
        xs =
            List.range x (x + w - 1)

        ys =
            List.range y (y + h - 1)
    in
    List.foldl
        (\i arr ->
            List.foldl
                (\j arr2 ->
                    Array2D.set i j 1 arr2
                )
                arr
                ys
        )
        ss
        xs
