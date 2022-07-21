module Lib.CoreEngine.GameComponents.Fireball.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetString)
import Lib.Render.Render exposing (renderSprite)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    let
        tmp =
            Debug.log "In" 1
    in
    if d.status == Alive then
        [ ( group []
                (if modBy 2 t == 0 then
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
