module Lib.CoreEngine.GameComponents.CutScene.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Color
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.DefinedTypes.Parser exposing (dgetLComponent)
import Lib.Render.Render exposing (renderSprite)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        data =
            d.extra

        componentsList =
            dgetLComponent data "_Child"
    in
    [ ( group []
            [ renderSprite gd
                []
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                "background"
            ]
      , 0
      )
    , ( group [] (List.map (\( comName, comModel ) -> comModel.view ( comModel.data, t ) gd) componentsList), 0 )
    ]
