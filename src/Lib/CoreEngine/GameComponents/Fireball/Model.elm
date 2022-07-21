module Lib.CoreEngine.GameComponents.Fireball.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.Physics.SolidCollision exposing (canMove)
import Math.Vector2 exposing (vec2)


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


collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 0
    , width = 200
    , height = 200
    }


simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 200
    , height = 200
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameFireballInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = info.initVelocity
            , mass = 20
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ collisionBox ]
            , extra = Dict.empty
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd _ ( d, t ) =
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

        -- { d | position = ( x + ceiling (vx / 1000), y + ceiling (vy / 1000) ) }
        _ ->
            case gct of
                GameInterCollisionMsg _ pd _ ->
                    ( { d | status = Dead t }, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                _ ->
                    ( d, [], ggd )
