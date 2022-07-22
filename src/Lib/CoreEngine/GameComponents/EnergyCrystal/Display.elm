module Lib.CoreEngine.GameComponents.EnergyCrystal.Display exposing (..)

import Base exposing (GlobalData)
import Canvas exposing (Renderable, circle, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (alpha)
import Color
import Lib.Coordinate.Coordinates exposing (heightToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Data, LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetLString)
import Lib.Render.Render exposing (transPoint)


view : ( Data, Int ) -> GameGlobalData -> GlobalData -> List ( Renderable, Int )
view ( model, _ ) ggd globalData =
    case model.status of
        Dead _ ->
            []

        _ ->
            [ ( group []
                    (List.append
                        [ shapes
                            [ alpha 1, fill Color.lightGreen ]
                            [ circle (transPoint globalData (getPositionUnderCamera model.position ggd))
                                (widthToReal globalData model.simplecheck.width)
                            ]
                        ]
                        (List.map
                            (\str ->
                                let
                                    list =
                                        String.split "_" str

                                    posX =
                                        Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head list)))

                                    posY =
                                        Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head (List.reverse list))))
                                in
                                shapes [ fill Color.yellow ] [ rect (transPoint globalData (getPositionUnderCamera ( posX, posY ) ggd)) (widthToReal globalData 5) (heightToReal globalData 5) ]
                            )
                            (dgetLString model.extra "EmitPos")
                        )
                    )
              , 0
              )
            ]
