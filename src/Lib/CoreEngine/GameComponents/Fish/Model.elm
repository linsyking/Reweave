module Lib.CoreEngine.GameComponents.Fish.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponent.ComponentHandler exposing (isAlive)
import Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetint)
import Quantity exposing (over_)


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


collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 11
    , width = 600
    , height = 500
    }


reboundBox : Box
reboundBox =
    { name = "reb"
    , offsetX = 0
    , offsetY = 0
    , width = 600
    , height = 490
    }


simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 600
    , height = 600
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameFishInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = info.initVelocity
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ collisionBox, reboundBox ]
            , extra =
                Dict.fromList
                    [ ( "TriggerUID", CDInt info.triggeruid )
                    , ( "BulletMethod", CDString info.bulletEmitMethod )
                    , ( "Timer", CDInt 0 )
                    , ( "Status", CDString "Stay" )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    case msg of
        Tick _ ->
            let
                timer =
                    dgetint d.extra "Timer" + 1

                requestMsg =
                    if modBy 30 timer == 0 then
                        [ GameParentMsg
                            (GameBulletInit
                                { initPosition = ( Tuple.first d.position - 100, Tuple.second d.position + 300 )
                                , initVelocity = ( -100, 0 )
                                , uid = 0
                                }
                            )
                        ]

                    else
                        []
            in
            ( { d | extra = d.extra |> dsetint "Timer" timer }, requestMsg, ggd )

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

                -- GameStringMsg "die" ->
                --     ( { d | status = Dead t }, [], ggd )
                _ ->
                    ( d, [], ggd )
