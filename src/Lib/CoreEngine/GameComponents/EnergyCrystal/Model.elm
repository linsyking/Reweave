module Lib.CoreEngine.GameComponents.EnergyCrystal.Model exposing
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
import Lib.CoreEngine.GameLayer.Common exposing (addenergy)
import Lib.DefinedTypes.Parser exposing (dgetbool, dgetint)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 300, 1100 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox
    , collisionbox = [ simplecheckBox ]
    , extra = Dict.empty
    , uid = 999
    }


{-| simplecheckBox
-}
simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 20
    , height = 40
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gct =
    case gct of
        GameEnergyCrystalInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ simplecheckBox ]
            , extra =
                Dict.fromList
                    [ ( "energy", CDInt info.energy )
                    , ( "recover", CDBool info.recoverable )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel mainMsg gct ggd _ ( d, t ) =
    let
        energy =
            dgetint d.extra "energy"
    in
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            case d.status of
                Dead _ ->
                    ( d, [], ggd )

                Alive ->
                    ( { d | status = Dead t }
                    , []
                    , { ggd
                        | energy =
                            addenergy ggd.energy (toFloat energy)
                      }
                    )

        _ ->
            case mainMsg of
                Tick _ ->
                    case d.status of
                        Alive ->
                            ( d, [], ggd )

                        Dead t0 ->
                            let
                                recover =
                                    dgetbool d.extra "recover"
                            in
                            if recover && t - t0 >= 400 then
                                ( { d | status = Alive }, [], ggd )

                            else
                                ( d, [], ggd )

                _ ->
                    ( d, [], ggd )
