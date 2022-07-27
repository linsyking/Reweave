module Lib.CoreEngine.GameLayer.Display exposing (view)

{-| This is the doc for this module

@docs view

-}

import Array
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group, rect, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (alpha)
import Color exposing (black)
import Lib.Coordinate.Coordinates exposing (heightToReal, posToReal, widthToReal)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (genView, getGameComponentCenter)
import Lib.CoreEngine.GameComponents.Player.FSM exposing (queryIsState)
import Lib.CoreEngine.GameLayer.Base exposing (GameLayerDepth(..))
import Lib.CoreEngine.GameLayer.Common exposing (Model, getDSEnergy, kineticCalc, searchUIDGC)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Lib.DefinedTypes.Parser exposing (dgetPlayer)
import Lib.Render.Chartlet exposing (renderChartletsBehindActor, renderChartletsBehindSolids, renderChartletsFront)
import Lib.Render.Energy exposing (renderEnergyPoint)
import Lib.Render.Render exposing (renderSpriteRawPos)
import Lib.Render.Solid exposing (renderSolids)


{-| view
-}
view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, ot ) ggd gd =
    let
        allobjs =
            Array.push model.player model.actors

        ( normal, override ) =
            splitOverrideGC allobjs

        t =
            if ggd.ingamepause then
                0

            else
                ot

        selected =
            ggd.selectobj

        -- ( px, py ) =
        --     model.player.data.position
    in
    group []
        [ --  group [ alpha 0.2 ] [ renderText gd 15 ("(" ++ String.fromInt px ++ ", " ++ String.fromInt py ++ ")") "Times New Roman" ( 0, 0 ) ]
          renderChartletsBehindActor model ggd gd
        , genView ggd gd t normal
        , if selected > 0 then
            let
                obj =
                    searchUIDGC selected allobjs
            in
            case Array.get obj allobjs of
                Just tk ->
                    let
                        ( p1, p2 ) =
                            getBoxPos tk.data.position tk.data.simplecheck
                    in
                    renderEnergyPoint t gd (kineticCalc tk.data.mass tk.data.velocity) ( getPositionUnderCamera p1 ggd, getPositionUnderCamera p2 ggd )

                _ ->
                    group [] []

          else
            group [] []
        , renderChartletsBehindSolids model ggd gd
        , renderSolids ggd gd
        , renderChartletsFront model ggd gd
        , genView ggd gd t override
        , if ggd.ingamepause && ggd.settingpause then
            shapes [ fill black, alpha 0.5 ] [ rect (posToReal gd ( 0, 0 )) (widthToReal gd 1920) (heightToReal gd 1080) ]

          else
            group [] []
        , if gd.visualaid then
            renderCursor t model ggd gd

          else
            group [] []
        ]


fromenergytoreal : Float -> Int
fromenergytoreal kk =
    if floor (kk / 10) > 20 then
        floor (kk / 10)

    else
        20


getCursor : Int -> Model -> GameGlobalData -> GlobalData -> ( Int, String )
getCursor t model ggd gd =
    if model.ignoreInput then
        ( 40, "" )

    else if t - model.lastuseEnergyTime < 15 then
        ( 40, "whiteshadow" )

    else if ggd.selectobj > 0 then
        if ggd.selectobj == model.player.data.uid then
            let
                pls =
                    dgetPlayer model.player.data.extra "model"

                isinair =
                    queryIsState
                        pls
                        "inair"
            in
            if isinair then
                ( 40, "whiteshadow" )

            else
                let
                    ( px, py ) =
                        posToReal gd (getPositionUnderCamera (getGameComponentCenter model.player) ggd)

                    ( mx, my ) =
                        gd.mousePos

                    pp =
                        ( px, py )

                    mm =
                        ( mx, my )

                    ( xsable, _ ) =
                        getDSEnergy pp mm gd ggd
                in
                if xsable > 0 then
                    ( fromenergytoreal xsable, "blueshadow" )

                else
                    ( 40, "whiteshadow" )

        else
            let
                tn =
                    searchUIDGC ggd.selectobj model.actors

                tac =
                    Array.get tn model.actors
            in
            case tac of
                Just thisactor ->
                    let
                        ( px, py ) =
                            posToReal gd (getPositionUnderCamera (getGameComponentCenter thisactor) ggd)

                        ( mx, my ) =
                            gd.mousePos

                        pp =
                            ( px, py )

                        mm =
                            ( mx, my )

                        ( xsable, _ ) =
                            getDSEnergy pp mm gd ggd
                    in
                    if xsable > 0 then
                        ( fromenergytoreal xsable, "blueshadow" )

                    else
                        ( 40, "whiteshadow" )

                Nothing ->
                    ( 40, "whiteshadow" )

    else
        ( 40, "whiteshadow" )


renderCursor : Int -> Model -> GameGlobalData -> GlobalData -> Renderable
renderCursor t model ggd gd =
    let
        ( mpx, mpy ) =
            gd.mousePos

        ( size, pic ) =
            getCursor t model ggd gd

        hs =
            floor (toFloat size / 2)
    in
    renderSpriteRawPos gd
        []
        ( mpx - widthToReal gd hs, mpy - heightToReal gd hs )
        ( size, size )
        pic


splitOverrideGC : Array.Array GameComponent -> ( Array.Array GameComponent, Array.Array GameComponent )
splitOverrideGC allobjs =
    ( Array.filter
        (\gc ->
            gc.name /= "CutScene"
        )
        allobjs
    , Array.filter
        (\gc ->
            gc.name == "CutScene"
        )
        allobjs
    )
