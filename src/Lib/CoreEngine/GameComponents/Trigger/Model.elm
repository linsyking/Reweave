module Lib.CoreEngine.GameComponents.Trigger.Model exposing
    ( initData
    , initModel
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs initModel

@docs updateModel

-}

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 100, 1100 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox ( 0, 0 )
    , collisionbox = [ simplecheckBox ( 0, 0 ) ]
    , extra = Dict.empty
    , uid = 888
    }


simplecheckBox : ( Int, Int ) -> Box
simplecheckBox ( w, h ) =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = w
    , height = h
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameTriggerInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox info.initSize
            , collisionbox = [ simplecheckBox info.initSize ]
            , extra =
                Dict.fromList
                    [ ( "target", CDInt info.triggerUID )
                    , ( "msg", CDString info.msg )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel _ gct ggd _ ( d, t ) =
    let
        isdead =
            case d.status of
                Alive ->
                    False

                _ ->
                    True
    in
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            if isdead then
                ( d, [], ggd )

            else
                let
                    msg =
                        dgetString d.extra "msg"

                    uid =
                        dgetint d.extra "target"
                in
                ( { d | status = Dead t }, [ GameActorUidMsg uid (GameStringMsg msg) ], ggd )

        _ ->
            ( d, [], ggd )
