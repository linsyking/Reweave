module Lib.CoreEngine.GameComponents.Spike.Model exposing
    ( initData
    , simplecheckBox
    , colBox
    , initModel
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs simplecheckBox

@docs colBox

@docs initModel

@docs updateModel

-}

import Base exposing (GlobalData, Msg)
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponents.Spike.Base exposing (SpikeDirection(..))
import Lib.DefinedTypes.Parser exposing (dgetint)


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 300, 1100 )
    , velocity = ( 0, 0 )
    , mass = 0
    , acceleration = ( 0, 0 )
    , simplecheck = simplecheckBox HorUp 1
    , collisionbox = [ simplecheckBox HorDown 1 ]
    , extra = Dict.empty
    , uid = 999
    }


{-| simplecheckBox
-}
simplecheckBox : SpikeDirection -> Int -> Box
simplecheckBox sd ss =
    case sd of
        HorUp ->
            { name = "sp"
            , offsetX = 0
            , offsetY = 0
            , width = ss * 32
            , height = 20
            }

        HorDown ->
            { name = "sp"
            , offsetX = 0
            , offsetY = 0
            , width = ss * 32
            , height = 20
            }

        VerLeft ->
            { name = "sp"
            , offsetX = 0
            , offsetY = 0
            , width = 20
            , height = ss * 32
            }

        VerRight ->
            { name = "sp"
            , offsetX = 0
            , offsetY = 0
            , width = 20
            , height = ss * 32
            }


{-| colBox
-}
colBox : SpikeDirection -> Int -> Box
colBox sd ss =
    case sd of
        HorUp ->
            { name = "col"
            , offsetX = 0
            , offsetY = 2
            , width = ss * 32
            , height = 18
            }

        HorDown ->
            { name = "col"
            , offsetX = 0
            , offsetY = 0
            , width = ss * 32
            , height = 18
            }

        VerLeft ->
            { name = "col"
            , offsetX = 2
            , offsetY = 0
            , width = 18
            , height = ss * 32
            }

        VerRight ->
            { name = "col"
            , offsetX = 0
            , offsetY = 0
            , width = 18
            , height = ss * 32
            }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gct =
    case gct of
        GameSpikeInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox info.direction info.spikesnum
            , collisionbox = [ colBox info.direction info.spikesnum ]
            , extra =
                Dict.fromList
                    [ ( "direction"
                      , CDInt
                            (case info.direction of
                                HorUp ->
                                    0

                                HorDown ->
                                    1

                                VerLeft ->
                                    2

                                VerRight ->
                                    3
                            )
                      )
                    , ( "number", CDInt info.spikesnum )
                    , ( "visible", CDBool info.visible )
                    ]
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
            let
                ( pvx, pvy ) =
                    pd.velocity

                dir =
                    dgetint d.extra "direction"
            in
            case dir of
                0 ->
                    if pvy > 0 then
                        ( d, [], ggd )

                    else
                        ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                1 ->
                    if pvy < 0 then
                        ( d, [], ggd )

                    else
                        ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                2 ->
                    if pvx > 0 then
                        ( d, [], ggd )

                    else
                        ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                3 ->
                    if pvx < 0 then
                        ( d, [], ggd )

                    else
                        ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

                _ ->
                    ( d, [ GameActorUidMsg pd.uid (GameStringMsg "die") ], ggd )

        _ ->
            ( d, [], ggd )
