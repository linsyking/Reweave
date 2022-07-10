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
    , mapsize = ( 260, 137 )
    }


sds : Array2D.Array2D Int
sds =
    Array2D.repeat 260 130 0


ps : Array2D.Array2D Int
ps =
    sds
        |> Array2D.appendColumn Array.empty 1
        |> Array2D.appendColumn Array.empty 1
        |> Array2D.appendColumn Array.empty 1
        |> Array2D.appendColumn Array.empty 1
        |> Array2D.appendColumn Array.empty 1
        |> Array2D.appendColumn Array.empty 1
        |> Array2D.appendColumn Array.empty 1
        |> buildrect ( 100, 115 ) ( 10, 10 )
        |> buildrect ( 120, 100 ) ( 10, 10 )


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
