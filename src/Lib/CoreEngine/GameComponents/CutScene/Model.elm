module Lib.CoreEngine.GameComponents.CutScene.Model exposing (..)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetString)


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
            , extra =
                Dict.fromList
                    (List.concat
                        [ decodeTalkings info.talkings
                        , [ ( "index", CDInt -1 )
                          , ( "timer", CDInt 0 )
                          , ( "textTyperCount", CDInt 0 )
                          , ( "onShow", CDBool False )
                          ]
                        ]
                    )
            , uid = info.uid
            }

        _ ->
            initData


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel msg gct ggd _ ( d, t ) =
    case gct of
        GameInterCollisionMsg "player" _ _ ->
            ( d, [ GameParentMsg (GameExitScene (dgetString d.extra "togo")) ], ggd )

        _ ->
            ( d, [], ggd )
