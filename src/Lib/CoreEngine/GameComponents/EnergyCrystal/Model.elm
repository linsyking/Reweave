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
import Lib.DefinedTypes.Parser exposing (dgetbool, dgetint, dsetbool, dsetint)


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
                    , ( "isalive", CDBool True )
                    , ( "deadtime", CDInt 0 )
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

        alive =
            dgetbool d.extra "isalive"

        deadtime =
            dgetint d.extra "deadtime"
    in
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            if alive then
                ( { d
                    | extra =
                        d.extra
                            |> dsetbool "isalive" False
                            |> dsetint "deadtime" t
                  }
                , []
                , { ggd
                    | energy =
                        addenergy ggd.energy (toFloat energy)
                  }
                )

            else
                ( d, [], ggd )

        _ ->
            case mainMsg of
                Tick _ ->
                    if alive then
                        let
                            ( px, py ) =
                                d.position
                        in
                        if modBy 70 t == 0 then
                            ( { d | position = ( px, py + 2 ) }, [], ggd )

                        else if modBy 70 t == 35 then
                            ( { d | position = ( px, py - 2 ) }, [], ggd )

                        else
                            ( d, [], ggd )

                    else
                        let
                            recover =
                                dgetbool d.extra "recover"
                        in
                        if recover && t - deadtime >= 400 then
                            ( { d | extra = d.extra |> dsetbool "isalive" True }, [], ggd )

                        else
                            ( d, [], ggd )

                _ ->
                    ( d, [], ggd )
