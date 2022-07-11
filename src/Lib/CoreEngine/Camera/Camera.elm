module Lib.CoreEngine.Camera.Camera exposing (..)

import Lib.CoreEngine.Base exposing (GameGlobalData, brickSize)
import Lib.CoreEngine.Camera.Base exposing (CameraData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Math.Vector2 exposing (Vec2, vec2)


getNewCamera : GameGlobalData -> Data -> CameraData
getNewCamera ggd d =
    let
        da =
            Debug.log "camera" cd

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

        ( px, py ) =
            ggd.camera.position

        rv =
            vec2 vx vy

        np =
            if Math.Vector2.length rv < 3 then
                ( px, py )

            else
                ( px + floor vx, py + floor vy )

        nc =
            { c | position = np }

        newggd =
            { ggd | camera = nc }
    in
    judgeInBound newggd


judgeInBound : GameGlobalData -> CameraData
judgeInBound ggd =
    let
        ( mw, mh ) =
            ggd.mapsize

        mapw =
            mw * brickSize

        maph =
            mh * brickSize

        ( cx, cy ) =
            ggd.camera.position

        ( cx2, cy2 ) =
            ( cx + cameraWidth - 1, cy + cameraHeight - 1 )
    in
    if cx >= 0 && cy >= 0 && cx2 < mapw && cy2 < maph then
        ggd.camera

    else
        let
            horizonD =
                if cx < 0 then
                    changeCP ggd.camera ( 0, cy )

                else if cx2 >= mapw then
                    changeCP ggd.camera ( mapw - cameraWidth, cy )

                else
                    ggd.camera

            ( ncx, _ ) =
                horizonD.position

            verticalD =
                if cy < 0 then
                    changeCP horizonD ( ncx, 0 )

                else if cy2 >= maph then
                    changeCP horizonD ( ncx, maph - cameraHeight )

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
            getCameraCenter ggd

        ( pvx, pvy ) =
            d.velocity

        -- prv = vec2 pvx -pvy
        -- prvd = Math.Vector2.length prv
        -- ddd =
        --     Math.Vector2.scale (0.02) prv
        subv =
            Math.Vector2.sub cp cc

        subvl =
            Math.Vector2.length subv

        sd =
            Debug.log "subvl" subvl

        subvlf =
            if subvl > 500 then
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
            ( floor (crx + 0.4 * toFloat cameraWidth), floor (cry + 0.1 * toFloat cameraHeight) )

        q =
            ( floor (crx + 0.6 * toFloat cameraWidth), floor (cry + 0.9 * toFloat cameraHeight) )
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


getCameraCenter : GameGlobalData -> Vec2
getCameraCenter ggd =
    let
        ( cx, cy ) =
            ggd.camera.position

        vx =
            toFloat cx + toFloat cameraWidth / 2

        vy =
            toFloat cy + toFloat cameraHeight / 2
    in
    vec2 vx vy
