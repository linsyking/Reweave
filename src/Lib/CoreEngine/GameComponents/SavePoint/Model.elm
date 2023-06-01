module Lib.CoreEngine.GameComponents.SavePoint.Model exposing
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
import Lib.DefinedTypes.Parser exposing (dgetint, dsetbool, dsetint)


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
    , width = 70
    , height = 120
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ gct =
    case gct of
        GameSavePointInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 0
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ simplecheckBox ]
            , extra =
                Dict.fromList
                    [ ( "Alive", CDBool True )
                    , ( "firsttouchtime", CDInt -10000 )
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
        GameInterCollisionMsg "player" _ _ ->
            let
                fir =
                    dgetint d.extra "firsttouchtime"
            in
            if t - fir <= 3 then
                ( { d
                    | extra =
                        d.extra
                            |> dsetint "firsttouchtime" t
                  }
                , []
                , ggd
                )

            else
                ( { d
                    | extra =
                        d.extra
                            |> dsetbool "Alive" False
                            |> dsetint "firsttouchtime" t
                  }
                , [ GameParentMsg (GameInfoPositionMsg "save" d.position) ]
                , ggd
                )

        _ ->
            ( d, [], ggd )
