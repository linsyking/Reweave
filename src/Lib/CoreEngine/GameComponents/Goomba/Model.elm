module Lib.CoreEngine.GameComponents.Goomba.Model exposing (..)

{-| This is the doc for this module

@docs initData

@docs collisionBox

@docs reboundBox

@docs simplecheckBox

@docs initModel

@docs updateModel

-}

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType, GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive)
import Lib.CoreEngine.GameComponents.Goomba.Movement exposing (checkCollision, solidCollisionMove)
import Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 100, 1500 )
    , velocity = ( 0, 0 )
    , mass = 70
    , acceleration = ( 0, -8 )
    , simplecheck = simplecheckBox
    , collisionbox = [ collisionBox, reboundBox ]
    , extra = Dict.empty
    , uid = 2
    }


{-| collisionBox
-}
collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 11
    , width = 70
    , height = 43
    }


{-| reboundBox
-}
reboundBox : Box
reboundBox =
    { name = "reb"
    , offsetX = 0
    , offsetY = 0
    , width = 70
    , height = 10
    }


{-| simplecheckBox
-}
simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 70
    , height = 53
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameGoombaInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = info.initVelocity
            , mass = 70
            , acceleration = ( 0, -8 )
            , simplecheck = simplecheckBox
            , collisionbox = [ collisionBox, reboundBox ]
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

                GameStringMsg "die" ->
                    ( { d | status = Dead t }, [], ggd )

                _ ->
                    ( d, [], ggd )
