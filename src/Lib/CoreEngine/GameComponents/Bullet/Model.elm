module Lib.CoreEngine.GameComponents.Bullet.Model exposing
    ( initData
    , collisionBox
    , simplecheckBox
    , initModel
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs collisionBox

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
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)
import Math.Vector2 exposing (vec2)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 900, 1850 )
    , velocity = ( -50, 0 )
    , mass = 5
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox
    , collisionbox = [ collisionBox ]
    , extra = Dict.empty
    , uid = 50
    }


{-| collisionBox
-}
collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 0
    , width = 20
    , height = 20
    }


{-| simplecheckBox
-}
simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 20
    , height = 20
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameBulletInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = info.initVelocity
            , mass = 10
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ collisionBox ]
            , extra = Dict.fromList [ ( "Picture", CDString info.picture ) ]
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
                GameSolidCollisionMsg _ ->
                    ( { d | status = Dead t }, [], ggd )

                _ ->
                    let
                        ( vx, vy ) =
                            d.velocity

                        ( x, y ) =
                            d.position
                    in
                    if (vx < 0 && not (canMove d ggd (vec2 -1 0))) || (vx > 0 && not (canMove d ggd (vec2 1 0))) || (vy > 0 && not (canMove d ggd (vec2 0 1))) || (vy < 0 && not (canMove d ggd (vec2 0 -1))) then
                        ( { d | status = Dead t, position = ( x + ceiling (vx / 1000), y + ceiling (vy / 1000) ) }, [], ggd )

                    else
                        ( d, [], ggd )

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

                GameInterCollisionMsg "fish" _ _ ->
                    ( d, [], ggd )

                GameStringMsg "die" ->
                    ( { d | status = Dead t }, [], ggd )

                GameInterCollisionMsg "player" pd _ ->
                    ( { d | status = Dead t }, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                GameInterCollisionMsg "goomba" pd _ ->
                    ( { d | status = Dead t }, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                _ ->
                    ( d, [], ggd )
