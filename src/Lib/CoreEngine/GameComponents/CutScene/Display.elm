module Lib.CoreEngine.GameComponents.CutScene.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.Component.Base exposing (ComponentTMsg(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.DefinedTypes.Parser exposing (dgetLComponent)
import Lib.Render.Render exposing (renderSprite)


{-| view
-}
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
                [ alpha 0.3 ]
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                "background"
            ]
      , 0
      )
    , ( group [] (List.map (\( _, comModel ) -> comModel.view ( comModel.data, t ) gd) componentsList), 10 )
    ]
