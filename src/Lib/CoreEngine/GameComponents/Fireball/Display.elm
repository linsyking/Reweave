module Lib.CoreEngine.GameComponents.Fireball.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.Render.Render exposing (renderSprite)


{-| view
-}
view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    if d.status == Alive then
        [ ( group []
                (if modBy 20 t < 10 then
                    [ renderSprite gd [] (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) "ot/fireball1"
                    ]

                 else
                    [ renderSprite gd [] (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) "ot/fireball2"
                    ]
                )
          , 0
          )
        ]

    else
        [ ( group [] [], 0 ) ]
