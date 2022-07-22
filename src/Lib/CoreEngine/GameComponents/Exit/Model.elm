module Lib.CoreEngine.GameComponents.Exit.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponents.Player.Base exposing (PlayerInitPosition(..))
import Lib.DefinedTypes.Parser exposing (dgetString, dgetbool, dgetint)


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


simplecheckBox : ( Int, Int ) -> Box
simplecheckBox ( w, h ) =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = w
    , height = h
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameExitInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox ( 3, 20 )
            , collisionbox = [ simplecheckBox ( 3, 20 ) ]
            , extra =
                Dict.fromList
                    [ ( "togo", CDString info.togo )
                    , ( "isdefault"
                      , CDBool
                            (case info.newPlayerPosition of
                                DefaultPlayerPosition ->
                                    True

                                _ ->
                                    False
                            )
                      )
                    , ( "posx"
                      , CDInt
                            (case info.newPlayerPosition of
                                DefaultPlayerPosition ->
                                    0

                                CustomPlayerPosition ( px, _ ) ->
                                    px
                            )
                      )
                    , ( "posy"
                      , CDInt
                            (case info.newPlayerPosition of
                                DefaultPlayerPosition ->
                                    0

                                CustomPlayerPosition ( _, py ) ->
                                    py
                            )
                      )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel _ gct ggd _ ( d, t ) =
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            let
                isdefault =
                    dgetbool d.extra "isdefault"
            in
            if isdefault then
                ( d, [ GameParentMsg (GameExitScene (dgetString d.extra "togo") DefaultPlayerPosition) ], ggd )

            else
                let
                    pp =
                        ( dgetint d.extra "posx", dgetint d.extra "posy" )
                in
                ( d, [ GameParentMsg (GameExitScene (dgetString d.extra "togo") (CustomPlayerPosition pp)) ], ggd )

        _ ->
            ( d, [], ggd )
