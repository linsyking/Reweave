module Lib.CoreEngine.GameComponents.CutScene.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Components.Dialog.Export as DialogE
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dsetLComponent)


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


decodeTalkings : List ( String, String, Bool ) -> List ( String, DefinedTypes )
decodeTalkings talkings =
    List.concat
        [ Tuple.second
            (List.foldl
                (\( charSprite, text, dir ) ( index, list ) ->
                    ( index + 1
                    , List.append list
                        [ ( String.fromInt index ++ "textExist", CDInt 100 )
                        , ( String.fromInt index ++ "CharSprite", CDString charSprite )
                        , ( String.fromInt index ++ "Text", CDString text )
                        , ( String.fromInt index ++ "Direction", CDBool dir )
                        ]
                    )
                )
                ( 0, [] )
                talkings
            )
        ]


initModel : Int -> GameComponentTMsg -> Data
initModel _ gcm =
    case gcm of
        GameCutSceneInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox info.initSize
            , collisionbox = [ simplecheckBox info.initSize ]
            , extra = Dict.fromList (decodeTalkings info.talkings)
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd globalData ( d, t ) =
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            ( { d
                | extra =
                    d.extra
                        |> dsetLComponent "_Child"
                            [ ( "Dialog", DialogE.initComponent 0 NullComponentMsg ) ]
              }
            , []
            , ggd
            )

        _ ->
            let
                data =
                    d.extra

                componentsList =
                    dgetLComponent data "_Child"

                ( tmpChildComponentsList, tmpChildComponentsMsg, _ ) =
                    List.foldl
                        (\( comName, comModel ) ( tmpComList, tmpComMsgList, tmpGData ) ->
                            let
                                ( tmpCom, tmpComMsg, gD ) =
                                    comModel.update msg NullComponentMsg tmpGData ( comModel.data, t )
                            in
                            ( List.append tmpComList [ ( comName, { comModel | data = tmpCom } ) ], List.append tmpComMsgList [ tmpComMsg ], gD )
                        )
                        ( [], [], globalData )
                        componentsList
            in
            ( { d | extra = d.extra |> dsetLComponent "_Child" tmpChildComponentsList }
            , []
            , ggd
            )
