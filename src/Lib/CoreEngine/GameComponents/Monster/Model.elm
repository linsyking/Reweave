module Lib.CoreEngine.GameComponents.Monster.Model exposing
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
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 300, 1100 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox ( 0, 0 )
    , collisionbox = [ simplecheckBox ( 0, 0 ) ]
    , extra = Dict.empty
    , uid = 999
    }


{-| simplecheckBox
-}
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
initModel _ gct =
    case gct of
        GameMonsterInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox info.size
            , collisionbox = [ simplecheckBox info.size ]
            , extra =
                Dict.fromList
                    [ ( "trigger", CDInt info.triggeruid )
                    , ( "pic", CDString info.pic )
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
        picname =
            dgetString d.extra "pic"
    in
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            case d.status of
                Dead _ ->
                    ( d, [], ggd )

                Alive ->
                    let
                        uid =
                            dgetint d.extra "trigger"
                    in
                    ( { d | status = Dead t }
                    , [ GameActorUidMsg uid (GameStringMsg "start")
                      , GameParentMsg (GameLStringMsg [ "collectmonster", picname ])
                      ]
                    , ggd
                    )

        _ ->
            ( d, [], ggd )
