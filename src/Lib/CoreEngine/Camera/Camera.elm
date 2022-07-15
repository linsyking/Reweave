module Lib.CoreEngine.Camera.Camera exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Math.Vector2 exposing (Vec2, vec2)


getNewCamera : GameGlobalData -> Data -> CameraData
getNewCamera ggd d =
    let
        cd =
            ggd.camera

        newv =
            if judgeInBox ggd d then
                dealInboundSpeed ggd

            else
                calcMoveVec ggd d

        newc =
            { cd | velocity = newv }

        newd =
            { ggd | camera = newc }
    in
    moveCamera newd


cameraWidth : Int
cameraWidth =
    1920


cameraHeight : Int
cameraHeight =
    1080


moveCamera : GameGlobalData -> CameraData
moveCamera ggd =
    let
        c =
            ggd.camera

        ( vx, vy ) =
            ggd.camera.velocity

        -- ddsd = Debug.log "Da" (vx, vy)
        ( px, py ) =
            ggd.camera.position

        rv =
            vec2 vx vy

        ( npx, npy ) =
            if Math.Vector2.length rv < 3 then
                ( px, py )

            else
                ( px + floor vx, py + floor vy )

        newv =
            if Math.Vector2.length rv > 1000 then
                ( 0, 0 )

            else
                ( vx, vy )

        movex =
            { c | position = ( npx, py ), velocity = newv }

        newggd =
            { ggd | camera = movex }

        dkd =
            judgeInBound newggd

        ( newdx, _ ) =
            dkd.position

        movey =
            { dkd | position = ( newdx, npy ) }

        ffggd =
            { newggd | camera = movey }
    in
    judgeInBound ffggd


judgeInBound : GameGlobalData -> CameraData
judgeInBound ggd =
    let
        ( mw, mh ) =
            ggd.mapsize

        ( ( lpx1, lpy1 ), ( mapw, maph ) ) =
            ggd.camera.visible

        ( cx, cy ) =
            ggd.camera.position

        ( cx2, cy2 ) =
            ( cx + cameraWidth - 1, cy + cameraHeight - 1 )
    in
    if cx >= lpx1 && cy >= lpy1 && cx2 <= mapw && cy2 <= maph then
        ggd.camera

    else
        let
            horizonD =
                if cx < lpx1 then
                    changeCP ggd.camera ( lpx1, cy )

                else if cx2 > mapw then
                    changeCP ggd.camera ( mapw - cameraWidth + 1, cy )

                else
                    ggd.camera

            ( ncx, _ ) =
                horizonD.position

            verticalD =
                if cy < lpy1 then
                    changeCP horizonD ( ncx, 0 )

                else if cy2 > maph then
                    changeCP horizonD ( ncx, maph - cameraHeight + 1 )

                else
                    horizonD
        in
        verticalD


changeCP : CameraData -> ( Int, Int ) -> CameraData
changeCP c q =
    { c | position = q }


dealInboundSpeed : GameGlobalData -> ( Float, Float )
dealInboundSpeed ggd =
    let
        ( vx, vy ) =
            ggd.camera.velocity

        v =
            vec2 vx vy
    in
    if Math.Vector2.length v < 6 || abs vx < 1 || abs vy < 1 then
        ( 0, 0 )

    else if Math.Vector2.length v < 10 then
        ( vx / 10, vy / 10 )

    else
        ( vx / 10, vy / 10 )


calcMoveVec : GameGlobalData -> Data -> ( Float, Float )
calcMoveVec ggd d =
    let
        cp =
            getPlayerCenter d

        cc =
            getCameraInboxCenter ggd

        subv =
            Math.Vector2.sub cp cc

        subvl =
            Math.Vector2.length subv

        subvlf =
            if subvl > 700 then
                subvl

            else if subvl > 500 then
                subvl * 2

            else
                subvl

        velc =
            Math.Vector2.scale (0.0001 * subvlf) subv
    in
    ( Math.Vector2.getX velc, Math.Vector2.getY velc )


judgeInBox : GameGlobalData -> Data -> Bool
judgeInBox ggd d =
    let
        ( ( x1, y1 ), ( x2, y2 ) ) =
            getBoxPos d.position d.simplecheck

        ( ( ix1, iy1 ), ( ix2, iy2 ) ) =
            getCameraInbox ggd
    in
    if x1 > ix1 && x2 < ix2 && y1 > iy1 && y2 < iy2 then
        True

    else
        False


getCameraInbox : GameGlobalData -> ( ( Int, Int ), ( Int, Int ) )
getCameraInbox ggd =
    let
        ( cx, cy ) =
            ggd.camera.position

        crx =
            toFloat cx

        cry =
            toFloat cy

        p =
            ( floor (crx + 0.2 * toFloat cameraWidth), floor (cry + 0.3 * toFloat cameraHeight) )

        q =
            ( floor (crx + 0.4 * toFloat cameraWidth), floor (cry + 0.4 * toFloat cameraHeight) )
    in
    ( p, q )


getPlayerCenter : Data -> Vec2
getPlayerCenter d =
    let
        ( ( x1, y1 ), ( x2, y2 ) ) =
            getBoxPos d.position d.simplecheck

        cx =
            (toFloat x1 + toFloat x2) / 2

        cy =
            (toFloat y1 + toFloat y2) / 2
    in
    vec2 cx cy


getCameraInboxCenter : GameGlobalData -> Vec2
getCameraInboxCenter ggd =
    let
        ( ( cx1, cy1 ), ( cx2, cy2 ) ) =
            getCameraInbox ggd

        vx =
            (toFloat cx1 + toFloat cx2) / 2

        vy =
            (toFloat cy1 + toFloat cy2) / 2
    in
    vec2 vx vy
