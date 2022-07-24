module Lib.CoreEngine.GameComponents.Player.Model exposing
    ( initData
    , initExtraData
    , collisionBox
    , initModel
    , updateModel
    , reboundPlayer
    )

{-| This is the doc for this module

@docs initData

@docs initExtraData

@docs collisionBox

@docs initModel

@docs updateModel

@docs reboundPlayer

-}

import Base exposing (GlobalData, Msg(..))
import Dict exposing (Dict)
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive)
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerState(..), SpaceLog(..), changebk, changehistory, fixnotrightdir, nullModel)
import Lib.CoreEngine.GameComponents.Player.InputFilter exposing (afterMove, preCheck)
import Lib.CoreEngine.GameComponents.Player.InputHandler exposing (changePlayerVelocity)
import Lib.CoreEngine.GameComponents.Player.Movement exposing (solidCollisionMove)
import Lib.CoreEngine.GameComponents.Player.StatesControl exposing (stateControl)
import Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)
import Lib.CoreEngine.Physics.NaiveCollision exposing (getBoxPos)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)
import Lib.DefinedTypes.Parser exposing (dgetPlayer, dsetPlayer, dsetint)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 100, 2000 )
    , velocity = ( 0, 0 )
    , mass = 50
    , acceleration = ( 0, -8 )
    , simplecheck = collisionBox
    , collisionbox = [ collisionBox ]
    , extra = initExtraData
    , uid = 1
    }


{-| initExtraData
-}
initExtraData : Dict String DefinedTypes
initExtraData =
    Dict.fromList
        [ ( "model", CDPlayerModel nullModel )
        ]


{-| collisionBox
-}
collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 5
    , offsetY = 15
    , width = 60
    , height = 105
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GamePlayerInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 50
            , acceleration = ( 0, -8 )
            , simplecheck = collisionBox
            , collisionbox = [ collisionBox ]
            , extra = initExtraData
            , uid = 1
            }

        _ ->
            initData


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    let
        model =
            dgetPlayer d.extra "model"
    in
    case msg of
        Tick _ ->
            case gct of
                GameSolidCollisionMsg cs ->
                    let
                        ( afterStateM, afterStateD ) =
                            stateControl t model d ggd

                        ( aftercheckM, aftercheckD ) =
                            preCheck t afterStateM afterStateD

                        ( afterVelM, afterVelD ) =
                            changePlayerVelocity t aftercheckD ggd aftercheckM

                        afterAccD =
                            putAccOn afterVelD

                        aftermoveD =
                            solidCollisionMove cs ggd afterAccD

                        aftermoveM =
                            afterMove afterVelM

                        exportmodel =
                            dsetPlayer "model" aftermoveM aftermoveD.extra
                    in
                    ( { aftermoveD | extra = exportmodel }, [], ggd )

                _ ->
                    if isAlive d then
                        let
                            ( afterStateM, afterStateD ) =
                                stateControl t model d ggd

                            ( aftercheckM, aftercheckD ) =
                                preCheck t afterStateM afterStateD

                            ( afterVelM, afterVelD ) =
                                changePlayerVelocity t aftercheckD ggd aftercheckM

                            afterAccD =
                                putAccOn afterVelD

                            aftermoveM =
                                afterMove afterVelM

                            modfycontrol =
                                fixnotrightdir aftermoveM.islastright aftermoveM.originKeys

                            afterFixCM =
                                { aftermoveM | islastright = modfycontrol }

                            recordState =
                                if afterFixCM.recordTimer == 10 then
                                    let
                                        tmpListPos =
                                            afterFixCM.listPosition

                                        ( name, time ) =
                                            case afterFixCM.playerStates of
                                                PlayerStates (x :: _) ->
                                                    ( x.stype, x.starttime )

                                                _ ->
                                                    ( "", 0 )

                                        newListPos =
                                            if List.length tmpListPos == 3 then
                                                List.append (List.drop 1 tmpListPos) [ ( Tuple.first d.position, Tuple.second d.position, ( name, t - time ) ) ]

                                            else
                                                List.append tmpListPos [ ( Tuple.first d.position, Tuple.second d.position, ( name, t - time ) ) ]
                                    in
                                    { afterFixCM | recordTimer = 0, listPosition = newListPos }

                                else
                                    { afterFixCM | recordTimer = afterFixCM.recordTimer + 1 }

                            exportmodel =
                                dsetPlayer "model" recordState afterAccD.extra

                            -- Check if is jump
                            -- isnewjump =
                            --     judgeFirstJump t afterStateM afterStateD
                        in
                        ( { afterAccD | extra = exportmodel }
                        , -- , if isnewjump && gd.unlockMaster then
                          --     [ GameParentMsg (GameStringIntMsg "addenergy" -150) ]
                          --   else
                          []
                        , ggd
                        )

                    else
                        let
                            afterAccD =
                                putAccOn d
                        in
                        ( afterAccD, [], ggd )

        KeyDown x ->
            let
                changebked =
                    changebk x 1 model.originKeys

                newmodel =
                    { model | originKeys = changebked, islastright = changehistory model.islastright x }

                exportmodel =
                    dsetPlayer "model" newmodel d.extra
            in
            ( { d | extra = exportmodel }, [], ggd )

        KeyUp x ->
            let
                newmodel =
                    { model | originKeys = changebk x 0 model.originKeys }

                exportmodel =
                    dsetPlayer "model" newmodel d.extra
            in
            ( { d | extra = exportmodel }, [], ggd )

        MouseDown 0 mp ->
            if judgeMouse gd mp (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) then
                ( d, [], { ggd | selectobj = d.uid } )

            else
                ( d, [], ggd )

        _ ->
            case gct of
                GameClearVelocity ->
                    ( { d | velocity = ( 0, 0 ) }, [], ggd )

                GameStringMsg "die" ->
                    ( { d | status = Dead t }, [], ggd )

                GameUseEnergy mp e ->
                    let
                        ndd =
                            changeCVel d mp e
                    in
                    ( ndd, [], ggd )

                GameInterCollisionMsg s icd bs ->
                    case s of
                        "goomba" ->
                            let
                                ( _, gbvy ) =
                                    icd.velocity

                                ( _, pvy ) =
                                    d.velocity
                            in
                            if List.length bs >= 2 then
                                if pvy < -100 || gbvy > 100 then
                                    -- Rebound!
                                    ( reboundPlayer gbvy d, [ GameActorUidMsg icd.uid (GameStringMsg "die") ], ggd )

                                else
                                    let
                                        ( _, ( _, y1 ) ) =
                                            getBoxPos d.position d.simplecheck

                                        ( ( _, y2 ), _ ) =
                                            getBoxPos icd.position icd.simplecheck
                                    in
                                    if y1 > y2 && y1 - y2 <= 21 then
                                        -- Rebound
                                        ( reboundPlayer gbvy d, [ GameActorUidMsg icd.uid (GameStringMsg "die") ], ggd )

                                    else
                                        -- Die
                                        ( { d | status = Dead t }, [], ggd )

                            else
                                case bs of
                                    [ xx ] ->
                                        case xx.name of
                                            "col" ->
                                                if pvy < -500 || gbvy > 100 then
                                                    -- Rebound!
                                                    ( reboundPlayer gbvy d, [ GameActorUidMsg icd.uid (GameStringMsg "die") ], ggd )

                                                else
                                                    -- Die
                                                    ( { d | status = Dead t }, [], ggd )

                                            "reb" ->
                                                ( reboundPlayer gbvy d, [ GameActorUidMsg icd.uid (GameStringMsg "die") ], ggd )

                                            _ ->
                                                ( d, [], ggd )

                                    _ ->
                                        ( d, [], ggd )

                        "ball" ->
                            let
                                ( pvx, pvy ) =
                                    icd.velocity

                                ( vx, vy ) =
                                    d.velocity

                                ( rvx, rvy ) =
                                    ( pvx - vx, pvy - vy )
                            in
                            if abs rvx > 100 || abs rvy > 100 then
                                ( { d | velocity = ( rvx / 2, rvy / 2 ) }, [], ggd )

                            else
                                ( { d | velocity = ( rvx * 1.3, rvy * 1.5 ) }, [], ggd )

                        _ ->
                            ( d, [], ggd )

                _ ->
                    ( d, [], ggd )


{-| reboundPlayer
-}
reboundPlayer : Float -> Data -> Data
reboundPlayer rbv d =
    let
        ( pvx, pvy ) =
            d.velocity

        ( px, py ) =
            d.position

        nv =
            if pvy > -200 then
                240

            else if pvy > -300 then
                300

            else if pvy > -360 then
                -pvy * 1.1

            else
                400
    in
    { d | velocity = ( pvx, nv + abs rbv ), position = ( px, py - 10 ) }
