module Lib.CoreEngine.GameComponents.Fish.Model exposing
    ( initData
    , simplecheckBox
    , initModel
    , changeStatus
    , changeVelocity
    , randomPos
    , getInitBulletsMsg
    , updateModel
    )

{-| This is the doc for this module

@docs initData

@docs simplecheckBox

@docs initModel

@docs changeStatus

@docs changeVelocity

@docs randomPos

@docs getInitBulletsMsg

@docs updateModel

-}

-- import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetString, dgetbool, dgetint, dsetbool, dsetint, dsetstring)
import Random


{-| initData
-}
initData : Data
initData =
    { status = Alive
    , position = ( 100, 1500 )
    , velocity = ( 0, 0 )
    , mass = 70
    , acceleration = ( 0, -8 )
    , simplecheck = simplecheckBox
    , collisionbox = [ simplecheckBox ]
    , extra = Dict.empty
    , uid = 2
    }


{-| simplecheckBox
-}
simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 600
    , height = 500
    }


colBox : Box
colBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 200
    , width = 600
    , height = 300
    }


{-| initModel
-}
initModel : Int -> GameComponentTMsg -> Data
initModel _ comMsg =
    case comMsg of
        GameFishInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = ( 0, 0 )
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ colBox ]
            , extra =
                Dict.fromList
                    [ ( "TriggerUID", CDInt info.triggeruid )
                    , ( "Timer", CDInt 0 )
                    , ( "Status", CDString "Away" )
                    , ( "Awake", CDBool False )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


{-| changeStatus
-}
changeStatus : Data -> Data
changeStatus model =
    let
        data =
            model.extra

        status =
            dgetString data "Status"

        timer =
            dgetint data "Timer"
    in
    case ( status, timer ) of
        ( "Away", 200 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "Come"
                        |> dsetint "Timer" 0
            }

        ( "Come", 2 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "FlyHigh"
                        |> dsetint "Timer" 0
            }

        ( "FlyHigh", 100 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "Create"
                        |> dsetint "Timer" 0
            }

        ( "Create", 500 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "FlyBack"
                        |> dsetint "Timer" 0
            }

        ( "FlyBack", 100 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "Away"
                        |> dsetint "Timer" 0
            }

        _ ->
            { model
                | extra =
                    data
                        |> dsetint "Timer" (timer + 1)
            }


{-| changeVelocity
-}
changeVelocity : Data -> Data
changeVelocity model =
    let
        data =
            model.extra

        status =
            dgetString data "Status"

        timer =
            dgetint data "Timer"
    in
    case status of
        "FlyHigh" ->
            if timer < 40 then
                { model | velocity = ( -45, 75 ) }

            else
                { model | velocity = ( 60, 75 ) }

        "FlyBack" ->
            if timer < 60 then
                { model | velocity = ( -60, -75 ) }

            else
                { model | velocity = ( 45, -75 ) }

        _ ->
            { model | velocity = ( 0, 0 ) }


{-| randomPos
-}
randomPos : Random.Seed -> Int -> Int -> Int
randomPos seed l r =
    Tuple.first (Random.step (Random.int l r) seed)


{-| getInitBulletsMsg
-}
getInitBulletsMsg : Int -> Data -> List GameComponentMsgType
getInitBulletsMsg t model =
    let
        data =
            model.extra

        status =
            dgetString data "Status"

        timer =
            dgetint data "Timer"
    in
    case status of
        "Away" ->
            if (modBy 100 timer == 0) || (modBy 100 timer == 20) || (modBy 100 timer == 30) then
                Tuple.first
                    (List.foldl
                        (\( posX, posY ) ( bulletList, index ) ->
                            ( List.append bulletList
                                [ GameParentMsg
                                    (GameBulletInit
                                        { initPosition = ( posX + floor (cos index * 430), posY + floor (sin index * 430) )
                                        , initVelocity = ( cos index * 100, sin index * -100 )
                                        , picture = "ot/scale"
                                        , uid = 0
                                        }
                                    )
                                ]
                            , index + 20
                            )
                        )
                        ( [], 0 )
                        (List.repeat 35 ( Tuple.first model.position + 300, Tuple.second model.position + 300 ))
                    )

            else
                []

        "Create" ->
            if (modBy 100 timer == 0) || (modBy 100 timer == 10) then
                Tuple.first
                    (List.foldl
                        (\( posX, posY ) ( bulletList, seed ) ->
                            ( List.append bulletList
                                [ GameParentMsg
                                    (GameBulletInit
                                        { initPosition = ( posX + randomPos seed -1500 1500, posY + randomPos seed 100 400 )
                                        , initVelocity = ( toFloat (randomPos seed -20 20), toFloat (randomPos seed -250 -50) )
                                        , picture = "ot/scale"
                                        , uid = 0
                                        }
                                    )
                                ]
                            , Tuple.second (Random.step (Random.int 0 10) seed)
                            )
                        )
                        ( [], Random.initialSeed t )
                        (List.repeat 10 ( Tuple.first model.position + 300, Tuple.second model.position + 300 ))
                    )

            else
                []

        _ ->
            []


{-| updateModel
-}
updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel mainMsg comMsg gameGlobalData _ ( model, t ) =
    case mainMsg of
        Tick _ ->
            if dgetbool model.extra "Awake" then
                let
                    requestMsg =
                        getInitBulletsMsg t model

                    newModel =
                        case model.status of
                            Dead _ ->
                                { model | velocity = ( Tuple.first model.velocity, Tuple.second model.velocity - 10 ) }

                            _ ->
                                model
                                    |> changeStatus
                                    |> changeVelocity
                in
                ( newModel, requestMsg, gameGlobalData )

            else
                let
                    newModel =
                        case model.status of
                            Dead _ ->
                                { model | velocity = ( Tuple.first model.velocity, Tuple.second model.velocity - 10 ) }

                            _ ->
                                model
                in
                ( newModel, [], gameGlobalData )

        _ ->
            case comMsg of
                GameInterCollisionMsg "player" _ _ ->
                    let
                        uid =
                            dgetint model.extra "TriggerUID"
                    in
                    ( { model | status = Dead t, extra = model.extra |> dsetstring "Status" "" }
                    , [ GameActorUidMsg uid (GameStringMsg "start")
                      , GameParentMsg (GameLStringMsg [ "collectmonster", "fish" ])
                      , GameActorNameMsg "bullet" (GameStringMsg "die")
                      ]
                    , gameGlobalData
                    )

                GameStringMsg "awake" ->
                    ( { model | extra = model.extra |> dsetbool "Awake" True }, [], gameGlobalData )

                _ ->
                    ( model, [], gameGlobalData )
