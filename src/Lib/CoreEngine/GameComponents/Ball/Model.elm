module Lib.CoreEngine.GameComponents.Ball.Model exposing
    ( initData
    , simplecheckBox
    , initModel
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs simplecheckBox

@docs initModel

@docs updateModel

-}

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive)
import Lib.CoreEngine.GameComponents.Ball.Movement exposing (checkCollision, solidCollisionMove)
import Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 900, 1850 )
    , velocity = ( -50, 0 )
    , mass = 5
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox 0
    , collisionbox = [ simplecheckBox 0 ]
    , extra = Dict.empty
    , uid = 50
    }


{-| simplecheckBox
-}
simplecheckBox : Int -> Box
simplecheckBox size =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = size
    , height = size
    }


colBox : Int -> Box
colBox size =
    let
        rs =
            toFloat size
    in
    { name = "sp"
    , offsetX = floor (rs / 4)
    , offsetY = floor (rs / 4)
    , width = floor (rs / 2)
    , height = floor (rs / 2)
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameBallInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 50
            , acceleration = ( 0, -8 )
            , simplecheck = simplecheckBox info.size
            , collisionbox = [ colBox info.size ]
            , extra = Dict.empty
            , uid = info.uid
            }

        _ ->
            initData


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    case msg of
        Tick _ ->
            case gct of
                GameSolidCollisionMsg cs ->
                    let
                        afterAccD =
                            putAccOn d

                        afterSolidCollisionD =
                            if isAlive d then
                                solidCollisionMove cs ggd afterAccD

                            else
                                afterAccD
                    in
                    ( afterSolidCollisionD, [], ggd )

                _ ->
                    let
                        afterAccD =
                            putAccOn d

                        afterCheckCD =
                            if isAlive d then
                                checkCollision ggd afterAccD

                            else
                                afterAccD
                    in
                    ( afterCheckCD, [], ggd )

        MouseDown 0 mp ->
            if judgeMouse gd mp (getPositionUnderCamera d.position ggd) ( d.simplecheck.width, d.simplecheck.height ) then
                ( d, [], { ggd | selectobj = d.uid } )

            else
                ( d, [], ggd )

        _ ->
            case gct of
                GameClearVelocity ->
                    ( { d | velocity = ( 0, 0 ) }, [], ggd )

                GameUseEnergy mp e ->
                    let
                        ndd =
                            changeCVel d mp e
                    in
                    ( ndd, [], ggd )

                GameInterCollisionMsg "player" pd _ ->
                    let
                        ( pvx, pvy ) =
                            pd.velocity

                        ( vx, vy ) =
                            d.velocity

                        ( rvx, rvy ) =
                            ( pvx - vx, pvy - vy )
                    in
                    if abs rvx > 200 || abs rvy > 200 then
                        ( { d | velocity = ( rvx / 2, rvy / 2 ) }, [], ggd )

                    else
                        ( { d | velocity = ( rvx, rvy ) }, [], ggd )

                GameInterCollisionMsg _ pd _ ->
                    ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                _ ->
                    ( d, [], ggd )
