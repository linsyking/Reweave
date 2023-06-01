module Lib.CoreEngine.GameComponents.Bone.Model exposing
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

import Base exposing (GlobalData, Msg)
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 300, 1100 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox 0
    , collisionbox = [ simplecheckBox 0 ]
    , extra = Dict.empty
    , uid = 999
    }


{-| simplecheckBox
-}
simplecheckBox : Int -> Box
simplecheckBox w =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = w
    , height = floor (toFloat w / 3 * 2)
    }


colBox : Int -> Box
colBox w =
    { name = "col"
    , offsetX = 10
    , offsetY = 20
    , width = w - 20
    , height = floor (toFloat w / 3 * 2) - 40
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gct =
    case gct of
        GameBoneInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox info.initSize
            , collisionbox = [ colBox info.initSize ]
            , extra = Dict.empty
            , uid = info.uid
            }

        _ ->
            initData


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel _ gct ggd _ ( d, t ) =
    case gct of
        GameInterCollisionMsg _ pd _ ->
            ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

        _ ->
            ( d, [], ggd )
