module Components.Menu.Menu exposing (..)

import Base exposing (GlobalData, Msg(..))
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Components.Menu.Map.Export as MenuMapE
import Components.Menu.Settings.Export as MenuSettingsE
import Components.Menu.Status.Export as MenuStatusE
import Constants exposing (..)
import Dict
import Lib.Component.Base exposing (Component, ComponentTMsg(..), Data, DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (..)
import Lib.DefinedTypes.Parser exposing (dgetDict, dgetLComponent, dgetbool, dsetLComponent, dsetbool)
import Lib.Render.Render exposing (renderText)


testData : Dict.Dict String DefinedTypes
testData =
    Dict.fromList
        [ ( "CharLife", CDInt 5 )
        , ( "CharEnergy", CDFloat 50.5 )
        , ( "CharPositionX", CDFloat 400 )
        , ( "CharPositionY", CDFloat 30 )
        , ( "MapWidth", CDFloat 1000 )
        , ( "MapHeight", CDFloat 500 )
        ]


initMenu : Int -> ComponentTMsg -> Data
initMenu _ _ =
    Dict.fromList
        [ ( "Show", CDBool True )
        , ( "Child"
          , CDLComponent
                [ ( "Status", MenuStatusE.initComponent 0 NullComponentMsg )
                , ( "Settings", MenuSettingsE.initComponent 0 NullComponentMsg )
                , ( "Map", MenuMapE.initComponent 0 NullComponentMsg )
                ]
          )
        , ( "Data", CDDict testData )
        ]
