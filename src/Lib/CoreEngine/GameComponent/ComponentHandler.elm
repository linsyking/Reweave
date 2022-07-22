module Lib.CoreEngine.GameComponent.ComponentHandler exposing (..)

{-| This is the doc for this module

@docs updateOneGameComponent

@docs updateSingleGameComponent

@docs updateSingleGameComponentByName

@docs getGameComponentFromName

@docs genView

@docs renderSingleObject

@docs getGameComponent

@docs simpleUpdateAllGameComponent

@docs isAlive

@docs sendManyMsgGameComponent

@docs sendManyGameComponentMsg

@docs splitPlayerObjs

@docs initGameComponent

@docs getGameComponentCenter

-}

import Array exposing (Array)
import Array.Extra
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data, GameComponent, GameComponentMsgType, GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos, judgeInCamera)
import Lib.Tools.Array exposing (locate)


{-| updateOneGameComponent
-}
updateOneGameComponent : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> Int -> GameComponent -> ( GameComponent, List GameComponentMsgType, GameGlobalData )
updateOneGameComponent msg ct ggd gd t c =
    let
        ( newx, newmsg, newggd ) =
            c.update msg ct ggd gd ( c.data, t )
    in
    ( { c | data = newx }, newmsg, newggd )


{-| updateSingleGameComponent
-}
updateSingleGameComponent : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> Int -> Int -> Array GameComponent -> ( Array GameComponent, List GameComponentMsgType, GameGlobalData )
updateSingleGameComponent msg ct ggd gd t n xs =
    case getGameComponent n xs of
        Just k ->
            let
                ( newx, newmsg, newggd ) =
                    k.update msg ct ggd gd ( k.data, t )
            in
            ( Array.set n { k | data = newx } xs, newmsg, newggd )

        Nothing ->
            ( xs, [], ggd )


{-| updateSingleGameComponentByName
-}
updateSingleGameComponentByName : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> Int -> String -> Array GameComponent -> ( Array GameComponent, List GameComponentMsgType, GameGlobalData )
updateSingleGameComponentByName msg ct ggd gd t s xs =
    let
        n =
            getGameComponentFromName s xs
    in
    case getGameComponent n xs of
        Just k ->
            let
                ( newx, newmsg, newggd ) =
                    k.update msg ct ggd gd ( k.data, t )
            in
            ( Array.set n { k | data = newx } xs, newmsg, newggd )

        Nothing ->
            ( xs, [], ggd )


{-| getGameComponentFromName
-}
getGameComponentFromName : String -> Array GameComponent -> Int
getGameComponentFromName s xs =
    Maybe.withDefault -1 (List.head (locate (\x -> x.name == s) xs))


{-| genView
-}
genView : GameGlobalData -> GlobalData -> Int -> Array GameComponent -> Renderable
genView ggd gd t xs =
    let
        allrs =
            Array.foldl
                (\x als ->
                    case renderSingleObject t x ggd gd of
                        Just tr ->
                            tr ++ als

                        Nothing ->
                            als
                )
                []
                xs

        res =
            List.sortWith (\( _, a ) ( _, b ) -> compare a b) allrs
    in
    group [] (List.map (\( x, _ ) -> x) res)


{-| renderSingleObject
-}
renderSingleObject : Int -> GameComponent -> GameGlobalData -> GlobalData -> Maybe (List ( Renderable, Int ))
renderSingleObject t gc ggd gd =
    if judgeInCamera gc ggd then
        -- Should show
        Just (gc.view ( gc.data, t ) ggd gd)

    else
        Nothing


{-| getGameComponent
-}
getGameComponent : Int -> Array GameComponent -> Maybe GameComponent
getGameComponent n xs =
    Array.get n xs


{-| simpleUpdateAllGameComponent
-}
simpleUpdateAllGameComponent : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> Int -> Array GameComponent -> ( Array GameComponent, List GameComponentMsgType, GameGlobalData )
simpleUpdateAllGameComponent msg gct ggd gd t gcs =
    Array.foldl
        (\x ( a, c, b ) ->
            let
                ( nbj, nmsg, nggd ) =
                    updateOneGameComponent msg gct b gd t x
            in
            ( Array.push nbj a, c ++ nmsg, nggd )
        )
        ( Array.empty, [], ggd )
        gcs


{-| isAlive
-}
isAlive : Data -> Bool
isAlive d =
    case d.status of
        Alive ->
            True

        _ ->
            False


{-| sendManyMsgGameComponent
-}
sendManyMsgGameComponent : Msg -> List GameComponentTMsg -> GameGlobalData -> GlobalData -> Int -> Int -> Array GameComponent -> ( Array GameComponent, List GameComponentMsgType, GameGlobalData )
sendManyMsgGameComponent msg gcts ggd gd n t gcs =
    List.foldl
        (\x ( a, c, b ) ->
            let
                oldgc =
                    Array.get n a
            in
            case oldgc of
                Just ogc ->
                    let
                        ( nbj, nmsg, nggd ) =
                            updateOneGameComponent msg x b gd t ogc
                    in
                    ( Array.set n nbj a, c ++ nmsg, nggd )

                Nothing ->
                    ( a, c, b )
        )
        ( gcs, [], ggd )
        gcts


{-| sendManyGameComponentMsg
-}
sendManyGameComponentMsg : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> List Int -> Int -> Array GameComponent -> ( Array GameComponent, List GameComponentMsgType, GameGlobalData )
sendManyGameComponentMsg msg gct ggd gd ns t gcs =
    List.foldl
        (\x ( a, c, b ) ->
            let
                oldgc =
                    Array.get x a
            in
            case oldgc of
                Just ogc ->
                    let
                        ( nbj, nmsg, nggd ) =
                            updateOneGameComponent msg gct b gd t ogc
                    in
                    ( Array.set x nbj a, c ++ nmsg, nggd )

                Nothing ->
                    ( a, c, b )
        )
        ( gcs, [], ggd )
        ns


{-| splitPlayerObjs
-}
splitPlayerObjs : Array GameComponent -> GameComponent -> ( GameComponent, Array GameComponent )
splitPlayerObjs gcs defaultplayer =
    let
        newplayer =
            Maybe.withDefault defaultplayer (Array.get (Array.length gcs - 1) gcs)
    in
    ( newplayer, Array.Extra.pop gcs )


{-| initGameComponent
-}
initGameComponent : Int -> GameComponentTMsg -> GameComponent -> GameComponent
initGameComponent t gct gc =
    { gc | data = gc.init t gct }



-- TODO: Write recursive message transform system like layer


{-| getGameComponentCenter
-}
getGameComponentCenter : GameComponent -> ( Int, Int )
getGameComponentCenter gc =
    let
        d =
            gc.data

        ( ( x1, y1 ), ( x2, y2 ) ) =
            getBoxPos d.position d.simplecheck

        cx =
            (toFloat x1 + toFloat x2) / 2

        cy =
            (toFloat y1 + toFloat y2) / 2
    in
    ( floor cx, floor cy )
