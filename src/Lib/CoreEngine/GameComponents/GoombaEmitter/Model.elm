module Lib.CoreEngine.GameComponents.GoombaEmitter.Model exposing (..)

import Base exposing (GlobalData, Msg)
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetfloat, dgetint)


initData : Data
initData =
    { status = Alive
    , position = ( 0, 0 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox
    , collisionbox = [ simplecheckBox ]
    , extra = Dict.empty
    , uid = 999
    }


simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 100
    , height = 100
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameGoombaEmitterInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ simplecheckBox ]
            , extra =
                Dict.fromList
                    [ ( "interval", CDInt info.interval )
                    , ( "goombaVelocityX", CDFloat (Tuple.first info.goombaVelocity) )
                    , ( "goombaVelocityY", CDFloat (Tuple.second info.goombaVelocity) )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel _ _ ggd _ ( d, t ) =
    let
        interval =
            dgetint d.extra "interval"
    in
    if modBy interval t == 0 then
        let
            v =
                ( dgetfloat d.extra "goombaVelocityX", dgetfloat d.extra "goombaVelocityY" )
        in
        ( d
        , [ GameParentMsg
                (GameGoombaInit
                    { initPosition = d.position
                    , initVelocity = v
                    , uid = 0
                    }
                )
          ]
        , ggd
        )

    else
        ( d, [], ggd )


queryModel : String -> ( Data, Int ) -> GameComponentTMsg
queryModel _ _ =
    NullGameComponentMsg
