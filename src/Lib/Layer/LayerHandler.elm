module Lib.Layer.LayerHandler exposing (..)

import Base exposing (GlobalData, Msg)
import Canvas exposing (Renderable)
import Lib.Layer.Base exposing (Layer, LayerMsg(..), LayerTarget(..))



--- Handle Layer


getLayerMsg : List ( LayerTarget, LayerMsg ) -> String -> List LayerMsg
getLayerMsg xs s =
    let
        ref =
            List.filter
                (\( x, _ ) ->
                    case x of
                        LayerName ln ->
                            if ln == s then
                                True

                            else
                                False

                        _ ->
                            False
                )
                xs
    in
    List.map (\( _, x ) -> x) ref


applyOnce : Msg -> Int -> a -> List ( LayerTarget, LayerMsg ) -> List ( LayerTarget, LayerMsg ) -> List ( String, Layer a b ) -> List ( String, Layer a b ) -> ( List ( LayerTarget, LayerMsg ), List ( String, Layer a b ), a )
applyOnce msg t cd lms ms dxs xs =
    case xs of
        [] ->
            ( lms, dxs, cd )

        ( name, layer ) :: lxs ->
            let
                data =
                    layer.data

                slname =
                    getLayerMsg ms name

                ( newdata, newcd, newmsg ) =
                    if List.isEmpty slname then
                        let
                            ( xxx, yyy, zzz ) =
                                layer.update msg NullLayerMsg ( data, t ) cd
                        in
                        ( xxx, yyy, [ zzz ] )

                    else
                        List.foldl
                            (\x ( dd, dcd, dmg ) ->
                                let
                                    ( xxx, yyy, zzz ) =
                                        layer.update msg x ( dd, t ) dcd
                                in
                                ( xxx, yyy, dmg ++ [ zzz ] )
                            )
                            ( data, cd, [] )
                            slname
            in
            applyOnce msg t newcd (lms ++ newmsg) ms (dxs ++ [ ( name, { layer | data = newdata } ) ]) lxs


applyOnceOnlyNew : Msg -> Int -> a -> List ( LayerTarget, LayerMsg ) -> List ( LayerTarget, LayerMsg ) -> List ( String, Layer a b ) -> List ( String, Layer a b ) -> ( List ( LayerTarget, LayerMsg ), List ( String, Layer a b ), a )
applyOnceOnlyNew msg t cd lms ms dxs xs =
    case xs of
        [] ->
            ( lms, dxs, cd )

        ( name, layer ) :: lxs ->
            let
                data =
                    layer.data

                slname =
                    getLayerMsg ms name

                ( newdata, newcd, newmsg ) =
                    if List.isEmpty slname then
                        ( data, cd, [] )

                    else
                        List.foldl
                            (\x ( dd, dcd, dmg ) ->
                                let
                                    ( xxx, yyy, zzz ) =
                                        layer.update msg x ( dd, t ) dcd
                                in
                                ( xxx, yyy, dmg ++ [ zzz ] )
                            )
                            ( data, cd, [] )
                            slname
            in
            applyOnceOnlyNew msg t newcd (lms ++ newmsg) ms (dxs ++ [ ( name, { layer | data = newdata } ) ]) lxs


updateOnce : Msg -> Int -> a -> List ( LayerTarget, LayerMsg ) -> List ( String, Layer a b ) -> ( List ( LayerTarget, LayerMsg ), List ( String, Layer a b ), a )
updateOnce msg t cd msgs xs =
    applyOnce msg t cd [] msgs [] xs


updateOnceOnlyNew : Msg -> Int -> a -> List ( LayerTarget, LayerMsg ) -> List ( String, Layer a b ) -> ( List ( LayerTarget, LayerMsg ), List ( String, Layer a b ), a )
updateOnceOnlyNew msg t cd msgs xs =
    applyOnceOnlyNew msg t cd [] msgs [] xs



--- msg, t, ms and xs doesn't change


updateLayer : Msg -> Int -> a -> List ( String, Layer a b ) -> ( List ( String, Layer a b ), a, List LayerMsg )
updateLayer msg t cd xs =
    let
        ( fmsg, fdata, fcd ) =
            updateOnce msg t cd [] xs
    in
    updateLayerRecursive msg t fcd fmsg fdata


judgeEnd : List ( LayerTarget, LayerMsg ) -> Bool
judgeEnd xs =
    List.all
        (\( x, _ ) ->
            case x of
                LayerParentScene ->
                    True

                NullLayerTarget ->
                    True

                _ ->
                    False
        )
        xs


filterLayerParentMsg : List ( LayerTarget, LayerMsg ) -> List ( LayerTarget, LayerMsg )
filterLayerParentMsg xs =
    List.filter
        (\( x, _ ) ->
            case x of
                LayerParentScene ->
                    True

                _ ->
                    False
        )
        xs


filterLayerParentMsgT : List ( LayerTarget, LayerMsg ) -> List LayerMsg
filterLayerParentMsgT xs =
    let
        css =
            List.filter
                (\( x, _ ) ->
                    case x of
                        LayerParentScene ->
                            True

                        _ ->
                            False
                )
                xs
    in
    List.map (\( _, x ) -> x) css


updateLayerRecursive : Msg -> Int -> a -> List ( LayerTarget, LayerMsg ) -> List ( String, Layer a b ) -> ( List ( String, Layer a b ), a, List LayerMsg )
updateLayerRecursive msg t cd msgs xs =
    if judgeEnd msgs then
        ( xs, cd, filterLayerParentMsgT msgs )

    else
        --- Update once
        let
            -- dsa = Debug.log "dsdda" xs
            ( newmsgs, newdata, newcd ) =
                updateOnceOnlyNew msg t cd msgs xs

            tmsgs =
                filterLayerParentMsg msgs
        in
        updateLayerRecursive msg t newcd (newmsgs ++ tmsgs) newdata


viewLayer : GlobalData -> Int -> a -> List ( String, Layer a b ) -> Renderable
viewLayer vp t cd xs =
    Canvas.group []
        (List.map (\( _, l ) -> l.view ( l.data, t ) cd vp) xs)
