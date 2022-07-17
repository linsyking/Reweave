module Components.Trans.Trans exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetLString, dgetString, dgetbool, dgetint, dsetbool, dsetint, dsetlstring, dsetstring)
import Lib.Render.Render exposing (renderSprite)
import String exposing (toInt)



--the length of the movement time


pausetime : Int
pausetime =
    40


initTrans : Int -> ComponentTMsg -> Data
initTrans t ct =
    case ct of
        ComponentLStringMsg (mode :: method :: dur :: _) ->
            Dict.fromList
                [ ( "rt", CDInt t ) --reference time
                , ( "mode", CDString mode )
                , ( "method", CDString method ) -- `plain` method to be implemented
                , ( "msg", CDLString [] )
                , ( "duration", CDInt (Maybe.withDefault 0 (toInt dur)) )
                , ( "state", CDBool True )
                ]

        _ ->
            Dict.fromList
                [ ( "rt", CDInt 0 ) --reference time
                , ( "mode", CDString "start" )
                , ( "method", CDString "cloud" ) -- `plain` method to be implemented
                , ( "msg", CDLString [] )
                , ( "duration", CDInt 0 )
                , ( "state", CDBool False )
                ]


updateTrans : Msg -> ComponentTMsg -> GlobalData -> ( Data, Int ) -> ( Data, ComponentTMsg, GlobalData )
updateTrans _ gMsg globalData ( d, t ) =
    let
        localtime =
            t - dgetint d "rt"

        duration =
            dgetint d "duration"
    in
    case gMsg of
        ComponentLStringMsg (mode :: method :: dur :: msg) ->
            let
                newd =
                    d
                        |> dsetbool "state" True
                        |> dsetlstring "msg" msg
                        |> dsetstring "mode" mode
                        |> dsetstring "method" method
                        |> dsetint "duration" (Maybe.withDefault 0 (toInt dur))
                        |> dsetint "rt" t
            in
            ( newd, NullComponentMsg, globalData )

        _ ->
            if localtime == duration + pausetime && dgetString d "mode" == "start" then
                ( d, ComponentLStringMsg (dgetLString d "msg"), globalData )

            else if localtime == duration + pausetime && dgetString d "mode" == "end" then
                ( d |> dsetbool "state" False, NullComponentMsg, globalData )

            else
                ( d, NullComponentMsg, globalData )


viewTrans : ( Data, Int ) -> GlobalData -> Renderable
viewTrans ( d, t ) gd =
    let
        localtime =
            t - dgetint d "rt"
    in
    if dgetbool d "state" then
        case dgetString d "mode" of
            "start" ->
                group []
                    [ renderSprite gd [] (shapePos localtime ( 2000, 270 ) ( 1000, 270 )) ( 353 * 6, 176 * 6 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, 100 ) ( -800, 100 )) ( 353 * 4, 176 * 4 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, -500 ) ( -700, -500 )) ( 353 * 6, 176 * 6 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( 2000, -90 ) ( 1080, -90 )) ( 353 * 4, 176 * 4 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, 100 ) ( -300, 100 )) ( 353 * 4, 176 * 4 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, 600 ) ( -500, 600 )) ( 353 * 5, 176 * 5 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, -160 ) ( -400, -160 )) ( 353 * 2, 176 * 2 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, 600 ) ( -600, 600 )) ( 353 * 3, 176 * 3 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( 2000, 800 ) ( 1000, 800 )) ( 353 * 3, 176 * 3 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 2100, -100 ) ( 1580, -100 )) ( 353 * 2, 176 * 2 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 2000, 400 ) ( 700, 400 )) ( 353 * 3, 176 * 3 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 2000, 150 ) ( 1700, 150 )) ( 353, 176 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( -2000, 700 ) ( 150, 700 )) ( 353, 176 ) "lcloud"
                    ]

            "end" ->
                group []
                    [ renderSprite gd [] (shapePos localtime ( 1000, 270 ) ( 2000, 270 )) ( 353 * 6, 176 * 6 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( -800, 100 ) ( -2000, 100 )) ( 353 * 4, 176 * 4 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -700, -500 ) ( -2000, -500 )) ( 353 * 6, 176 * 6 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( 1080, -90 ) ( 2000, -90 )) ( 353 * 4, 176 * 4 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( -300, 100 ) ( -2000, 100 )) ( 353 * 4, 176 * 4 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -500, 600 ) ( -2000, 600 )) ( 353 * 5, 176 * 5 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -400, -160 ) ( -2000, -160 )) ( 353 * 2, 176 * 2 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( -600, 600 ) ( -2000, 600 )) ( 353 * 3, 176 * 3 ) "lcloud"
                    , renderSprite gd [] (shapePos localtime ( 1000, 800 ) ( 2000, 800 )) ( 353 * 3, 176 * 3 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 1580, -100 ) ( 2100, -100 )) ( 353 * 2, 176 * 2 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 700, 400 ) ( 2000, 400 )) ( 353 * 3, 176 * 3 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 1700, 150 ) ( 2000, 150 )) ( 353, 176 ) "rcloud"
                    , renderSprite gd [] (shapePos localtime ( 150, 700 ) ( -2000, 700 )) ( 353, 176 ) "lcloud"
                    ]

            _ ->
                group [] []

    else
        group [] []


shapePos : Int -> ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
shapePos time ( startX, startY ) ( endX, endY ) =
    if time > pausetime then
        ( endX, endY )

    else
        ( startX + (endX - startX) // pausetime * time, startY + (endY - startY) // pausetime * time )
