module Lib.CoreEngine.GameComponents.Exit.Display exposing (..)

-- Display is only for testing

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.Render.Render exposing (renderSprite)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    [ ( group []
            [ renderSprite gd
                []
                (getPositionUnderCamera ( Tuple.first d.position - 100, Tuple.second d.position - 180 ) ggd)
                ( 200, 200 )
                "ot/transfer"
            ]
      , 0
      )
    ]
