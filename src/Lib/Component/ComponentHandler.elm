module Lib.Component.ComponentHandler exposing (..)

import Array exposing (Array)
import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (Component, ComponentTMsg(..))
import Lib.Tools.Array exposing (locate)


updateComponents : Int -> Msg -> GlobalData -> Array Component -> ( Array Component, List ComponentTMsg, GlobalData )
updateComponents t msg gd xs =
    Array.foldl
        (\x ( acs, ct, mlgg ) ->
            let
                ( newx, newmsg, newgd ) =
                    x.update msg NullComponentMsg mlgg ( x.data, t )
            in
            ( Array.push { x | data = newx } acs, ct ++ [ newmsg ], newgd )
        )
        ( Array.empty, [], gd )
        xs


updateOneComponent : Msg -> ComponentTMsg -> GlobalData -> Int -> Component -> ( Component, ComponentTMsg, GlobalData )
updateOneComponent msg ct gd t c =
    let
        ( newx, newmsg, newgd ) =
            c.update msg ct gd ( c.data, t )
    in
    ( { c | data = newx }, newmsg, newgd )


updateSingleComponent : Msg -> ComponentTMsg -> GlobalData -> Int -> Int -> Array Component -> ( Array Component, ComponentTMsg, GlobalData )
updateSingleComponent msg ct gd t n xs =
    case getComponent n xs of
        Just k ->
            let
                ( newx, newmsg, newgd ) =
                    k.update msg ct gd ( k.data, t )
            in
            ( Array.set n { k | data = newx } xs, newmsg, newgd )

        Nothing ->
            ( xs, NullComponentMsg, gd )


updateSingleComponentByName : Msg -> ComponentTMsg -> GlobalData -> Int -> String -> Array Component -> ( Array Component, ComponentTMsg, GlobalData )
updateSingleComponentByName msg ct gd t s xs =
    let
        n =
            getComponentFromName s xs
    in
    case getComponent n xs of
        Just k ->
            let
                ( newx, newmsg, newgd ) =
                    k.update msg ct gd ( k.data, t )
            in
            ( Array.set n { k | data = newx } xs, newmsg, newgd )

        Nothing ->
            ( xs, NullComponentMsg, gd )


genView : GlobalData -> Int -> Array Component -> Renderable
genView vp t xs =
    Canvas.group [] (Array.toList (Array.map (\x -> x.view ( x.data, t ) vp) xs))


getComponent : Int -> Array Component -> Maybe Component
getComponent n xs =
    Array.get n xs


getComponentFromName : String -> Array Component -> Int
getComponentFromName s xs =
    Maybe.withDefault -1 (List.head (locate (\x -> x.name == s) xs))


queryComponent : Int -> String -> Int -> Array Component -> ComponentTMsg
queryComponent n s t xs =
    case getComponent n xs of
        Just k ->
            k.query s ( k.data, t )

        Nothing ->
            NullComponentMsg
