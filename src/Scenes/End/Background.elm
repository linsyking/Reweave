module Scenes.End.Background exposing (background)

{-| This is the doc for this module

@docs background

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.BackgroundLayer.ImageRolling exposing (genBackground)
import Lib.CoreEngine.Base exposing (GameGlobalData)


{-| background
-}
background : Int -> GameGlobalData -> GlobalData -> Renderable
background _ ggd gd =
    let
        t =
            modBy 2000 gd.scenestarttime

        allre =
            List.filter
                (\( _, ( s1, _ ), ( _, e2 ) ) ->
                    s1 <= t && t <= e2
                )
                allbgs
    in
    group []
        (List.map
            (\( mapname, ( s1, s2 ), ( e1, e2 ) ) ->
                if s2 == 0 && t == 0 then
                    genBackground 0.06 0.7 mapname ggd gd

                else if t <= s2 then
                    -- Start
                    let
                        progress =
                            toFloat (t - s1) / toFloat (s2 - s1) * 0.7
                    in
                    genBackground 0.06 progress mapname ggd gd

                else if t >= e1 then
                    -- End
                    let
                        progress =
                            toFloat (e2 - t) / toFloat (e2 - e1) * 0.7
                    in
                    genBackground 0.06 progress mapname ggd gd

                else
                    genBackground 0.06 0.7 mapname ggd gd
            )
            allre
        )



-- genBackground 0.18 "bg/jn" ggd gd


allbgs : List ( String, ( Int, Int ), ( Int, Int ) )
allbgs =
    [ ( "bg/jn", ( 0, 0 ), ( 400, 600 ) )
    , ( "bg/dh", ( 400, 600 ), ( 800, 1000 ) )
    , ( "bg/zy", ( 800, 1000 ), ( 1200, 1400 ) )
    , ( "bg/lx", ( 1200, 1400 ), ( 1600, 1800 ) )
    , ( "bg/bm", ( 1600, 1800 ), ( 2000, 2200 ) )
    ]
