module Lib.CoreEngine.GameComponents.Ball.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.Physics.Acceleration exposing (putAccOn)
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove)
import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)
import Math.Vector2 exposing (vec2)


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


simplecheckBox : Int -> Box
simplecheckBox size =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = size
    , height = size
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameBallInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = floor (toFloat info.size * 2)
            , acceleration = ( 0, -8 )
            , simplecheck = simplecheckBox info.size
            , collisionbox = [ simplecheckBox info.size ]
            , extra = Dict.empty
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd gd ( d, t ) =
    case msg of
        Tick _ ->
            let
                newModel =
                    putAccOn d

                ( vx, vy ) =
                    newModel.velocity

                ( x, y ) =
                    newModel.position
            in
            if (vx < 0 && not (canMove d ggd (vec2 -1 0))) || (vx > 0 && not (canMove d ggd (vec2 1 0))) || (vy > 0 && not (canMove d ggd (vec2 0 1))) || (vy < 0 && not (canMove d ggd (vec2 0 -1))) then
                ( { newModel | status = Dead t, position = ( x + ceiling (vx / 1000), y + ceiling (vy / 1000) ) }, [], ggd )

            else
                ( newModel, [], ggd )

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

                GameInterCollisionMsg "turtle" pd _ ->
                    let
                        mass =
                            d.mass
                    in
                    if mass >= 400 then
                        ( { d | status = Dead t }, [ GameActorUidMsg pd.uid (GameStringMsg "decreaseHP") ], ggd )

                    else
                        ( d, [], ggd )

                GameInterCollisionMsg "fireball" _ _ ->
                    ( d, [], ggd )

                GameInterCollisionMsg _ pd _ ->
                    ( { d | status = Dead t }, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                _ ->
                    ( d, [], ggd )
