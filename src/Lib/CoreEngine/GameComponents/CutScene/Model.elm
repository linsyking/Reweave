module Lib.CoreEngine.GameComponents.CutScene.Model exposing
    ( initData
    , simplecheckBox
    , decodeTalkings
    , initModel
    , handlestart
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs simplecheckBox

@docs decodeTalkings

@docs initModel

@docs handlestart

@docs updateModel

-}

import Base exposing (GlobalData, Msg(..))
import Components.Dialog.Export as DialogE
import Dict
import Lib.Component.Base exposing (ComponentTMsg(..), DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetLComponent, dgetbool, dsetLComponent)


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


{-| decodeTalkings
-}
decodeTalkings : List ( String, String ) -> List ( String, DefinedTypes )
decodeTalkings talkings =
    List.concat
        [ Tuple.second
            (List.foldl
                (\( charSprite, text ) ( index, list ) ->
                    ( index + 1
                    , List.append list
                        [ ( String.fromInt index ++ "textExist", CDInt 100 )
                        , ( String.fromInt index ++ "CharSprite", CDString charSprite )
                        , ( String.fromInt index ++ "Text", CDString text )
                        ]
                    )
                )
                ( 0, [] )
                talkings
            )
        ]


{-| initModel
-}
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
            , extra = Dict.fromList (decodeTalkings info.talkings ++ [ ( "iscol", CDBool info.isCol ) ])
            , uid = info.uid
            }

        _ ->
            initData


{-| handlestart
-}
handlestart : Data -> GameGlobalData -> ( Data, List GameComponentMsgType, GameGlobalData )
handlestart d ggd =
    let
        talkings =
            d.extra
    in
    if dgetLComponent d.extra "_Child" == [] then
        ( { d
            | extra =
                d.extra
                    |> dsetLComponent "_Child"
                        [ ( "Dialog", DialogE.initComponent 0 (ComponentStringDictMsg "" talkings) ) ]
          }
        , [ GameParentMsg (GameStringMsg "ignoreinput") ]
        , ggd
        )

    else
        ( d, [], ggd )


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd globalData ( d, t ) =
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
            if not (dgetbool d.extra "iscol") || isdead then
                ( d, [], ggd )

            else
                handlestart d ggd

        GameStringMsg "start" ->
            if isdead then
                ( d, [], ggd )

            else
                handlestart d ggd

        GameStringMsg "skip" ->
            if dgetLComponent d.extra "_Child" == [] then
                ( d, [], ggd )

            else
                ( { d | extra = Dict.empty }, [], ggd )

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
            case tmpChildComponentsMsg of
                [ [ ComponentStringMsg "OnEnd" ] ] ->
                    ( { d | extra = d.extra |> dsetLComponent "_Child" [], status = Dead t }
                    , [ GameParentMsg (GameStringMsg "reactinput") ]
                    , ggd
                    )

                _ ->
                    ( { d | extra = d.extra |> dsetLComponent "_Child" tmpChildComponentsList }
                    , []
                    , ggd
                    )
