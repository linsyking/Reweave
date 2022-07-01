module Lib.CoreEngine.GameComponent.ComponentHandler exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.CoreEngine.Base exposing (GameGloablData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent, GameComponentTMsg(..))


updateOneGameComponent : Msg -> GameComponentTMsg -> GameGloablData -> GlobalData -> Int -> GameComponent -> ( GameComponent, GameComponentTMsg, GameGloablData )
updateOneGameComponent msg ct ggd gd t c =
    let
        ( newx, newmsg, newggd ) =
            c.update msg ct ggd gd ( c.data, t )
    in
    ( { c | data = newx }, newmsg, newggd )


updateSingleGameComponent : Msg -> GameComponentTMsg -> GameGloablData -> GlobalData -> Int -> Int -> Array GameComponent -> ( Array GameComponent, GameComponentTMsg, GameGloablData )
updateSingleGameComponent msg ct ggd gd t n xs =
    case getGameComponent n xs of
        Just k ->
            let
                ( newx, newmsg, newggd ) =
                    k.update msg ct ggd gd ( k.data, t )
            in
            ( Array.set n { k | data = newx } xs, newmsg, newggd )

        Nothing ->
            ( xs, NullGameComponentMsg, ggd )


genView : GameGloablData -> GlobalData -> Int -> Array GameComponent -> Renderable
genView ggd vp t xs =
    Canvas.group [] (Array.toList (Array.map (\x -> x.view ( x.data, t ) ggd vp) xs))


getGameComponent : Int -> Array GameComponent -> Maybe GameComponent
getGameComponent n xs =
    Array.get n xs


queryGameComponent : Int -> String -> Int -> Array GameComponent -> GameComponentTMsg
queryGameComponent n s t xs =
    case getGameComponent n xs of
        Just k ->
            k.query s ( k.data, t )

        Nothing ->
            NullGameComponentMsg
