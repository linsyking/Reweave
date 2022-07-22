module Lib.CoreEngine.GameComponents.EnergyCrystal.Model exposing
    ( initData
    , simplecheckBox
    , initModel
    , randomPos
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs simplecheckBox

@docs initModel

@docs randomPos

@docs updateModel

-}

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetLString, dsetlstring)
import Random


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
        GameEnergyCrystalInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox ( info.initRadius, info.initRadius )
            , collisionbox = [ simplecheckBox ( info.initRadius, info.initRadius ) ]
            , extra =
                Dict.fromList
                    [ ( "EmitPos", CDLString (List.repeat 5 (String.fromInt (Tuple.first info.initPosition) ++ "_" ++ String.fromInt (Tuple.second info.initPosition))) )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


{-| randomPos
-}
randomPos : Int -> Int -> Int -> Int
randomPos t l r =
    Tuple.first (Random.step (Random.int l r) (Random.initialSeed t))


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel mainMsg gct ggd _ ( d, t ) =
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            ( { d | status = Dead t }
            , []
            , { ggd
                | energy =
                    if ggd.energy + 100 > 2000 then
                        2000

                    else
                        ggd.energy + 200
              }
            )

        _ ->
            case mainMsg of
                Tick _ ->
                    let
                        tmpEmitPos =
                            dgetLString d.extra "EmitPos"

                        newEmitPos =
                            List.map
                                (\str ->
                                    let
                                        list =
                                            String.split "_" str

                                        posX =
                                            Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head list)))

                                        posY =
                                            Maybe.withDefault 0 (String.toInt (Maybe.withDefault "" (List.head (List.reverse list))))
                                    in
                                    String.fromInt (posX + randomPos (t + posY) -d.simplecheck.width d.simplecheck.width) ++ "_" ++ String.fromInt (posY + randomPos (t + posX) (-d.simplecheck.width - 1) (d.simplecheck.width + 1))
                                )
                                tmpEmitPos
                                |> List.drop 1
                    in
                    ( { d | extra = d.extra |> dsetlstring "EmitPos" (newEmitPos ++ [ String.fromInt (Tuple.first d.position) ++ "_" ++ String.fromInt (Tuple.second d.position) ]) }, [], ggd )

                _ ->
                    ( d, [], ggd )
