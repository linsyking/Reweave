module Lib.CoreEngine.GameComponents.Player.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Canvas.Settings.Advanced exposing (alpha)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerState(..))
import Lib.DefinedTypes.Parser exposing (dgetPlayer)
import Lib.Render.Render exposing (renderSprite, renderText)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( d, t ) ggd gd =
    [ ( group []
            [ renderSprite gd
                [ alpha
                    (if ggd.selectobj == d.uid then
                        1

                     else
                        0.5
                    )
                ]
                (getPositionUnderCamera d.position ggd)
                ( d.simplecheck.width, d.simplecheck.height )
                "background"
            , renderText gd 20 (getStateNumber t d) "sans-serif" (getPositionUnderCamera d.position ggd)
            ]
      , 0
      )
    ]


getStateNumber : Int -> Data -> String
getStateNumber t d =
    let
        model =
            dgetPlayer d.extra "model"

        sn =
            model.playerStates

        ( name, time ) =
            case sn of
                PlayerStates (x :: _) ->
                    ( x.stype, x.starttime )

                _ ->
                    ( "", 0 )

        ds =
            modBy 10 (t - time)
    in
    name ++ String.fromInt ds
