module Lib.CoreEngine.GameComponents.Turtle.Model exposing (..)

-- import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetint, dsetstring)
import Random


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


simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 600
    , height = 500
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ comMsg =
    case comMsg of
        GameTurtleInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = info.initVelocity
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ simplecheckBox ]
            , extra =
                Dict.fromList
                    [ ( "TriggerUID", CDInt info.triggeruid )
                    , ( "BulletMethod", CDString info.bulletEmitMethod )
                    , ( "Timer", CDInt 0 )
                    , ( "Status", CDString "Away" )
                    ]
            , uid = info.uid
            }

        _ ->
            initData


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
        ( "Away", 150 ) ->
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
                        |> dsetstring "Status" "Wave"
                        |> dsetint "Timer" 0
            }

        ( "Wave", 9 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "JumpUp"
                        |> dsetint "Timer" 0
            }

        ( "JumpUp", 50 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "JumpDown"
                        |> dsetint "Timer" 0
            }

        ( "JumpDown", 50 ) ->
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
                        |> dsetstring "Status" "Away"
                        |> dsetint "Timer" 0
            }

        _ ->
            { model
                | extra =
                    data
                        |> dsetint "Timer" (timer + 1)
            }


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
        "JumpUp" ->
            { model | velocity = ( 0, 20 - toFloat timer ) }

        "Wave" ->
            { model | velocity = ( 0, 30 ) }

        "JumpDown" ->
            { model | velocity = ( 0, -50 + toFloat timer ) }

        _ ->
            { model | velocity = ( 0, 0 ) }


randomPos : Random.Seed -> Int -> Int -> Int
randomPos seed l r =
    Tuple.first (Random.step (Random.int l r) seed)


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
            if (modBy 150 timer == 0) || (modBy 150 timer == 60) then
                Tuple.first
                    (List.foldl
                        (\( posX, posY ) ( bulletList, index ) ->
                            ( List.append bulletList
                                [ GameParentMsg
                                    (GameFireballInit
                                        { initPosition = ( posX + floor (cos (degrees index) * 400), posY + floor (sin (degrees index) * 400) )
                                        , initVelocity = ( cos (degrees index) * 100, sin (degrees index) * -100 )
                                        , uid = 0
                                        }
                                    )
                                ]
                            , index + 36
                            )
                        )
                        ( [], toFloat (modBy 100 timer - 5) )
                        (List.repeat 10 ( Tuple.first model.position + 250, Tuple.second model.position + 300 ))
                    )

            else if modBy 150 timer == 100 then
                Tuple.first
                    (List.foldl
                        (\( posX, posY ) ( bulletList, index ) ->
                            ( List.append bulletList
                                [ GameParentMsg
                                    (GameFireballInit
                                        { initPosition = ( posX + floor (cos (degrees index) * 400), posY + floor (sin (degrees index) * 400) )
                                        , initVelocity = ( cos (degrees index) * 100, sin (degrees index) * -100 )
                                        , uid = 0
                                        }
                                    )
                                ]
                            , index + 18
                            )
                        )
                        ( [], 0 )
                        (List.repeat 20 ( Tuple.first model.position + 250, Tuple.second model.position + 300 ))
                    )

            else
                []

        "Create" ->
            if (modBy 150 timer == 0) || (modBy 150 timer == 80) then
                Tuple.first
                    (List.foldl
                        (\( posX, _ ) ( bulletList, seed ) ->
                            ( List.append bulletList
                                [ GameParentMsg
                                    (GameFireballInit
                                        { initPosition = ( posX + randomPos seed -1000 1000, 500 )
                                        , initVelocity = ( 0, toFloat (randomPos seed -150 -50) )
                                        , uid = 0
                                        }
                                    )
                                ]
                            , Tuple.second (Random.step (Random.int 0 10) seed)
                            )
                        )
                        ( [], Random.initialSeed t )
                        (List.repeat 10 ( Tuple.first model.position + 300, Tuple.second model.position + 250 ))
                    )

            else
                []

        "Wave" ->
            if modBy 3 timer == 0 then
                [ GameParentMsg
                    (GameFireballInit
                        { initPosition = ( Tuple.first model.position, Tuple.second model.position + 500 )
                        , initVelocity = ( -200, 0 )
                        , uid = 0
                        }
                    )
                , GameParentMsg
                    (GameFireballInit
                        { initPosition = ( Tuple.first model.position + 600, Tuple.second model.position + 500 )
                        , initVelocity = ( 200, 0 )
                        , uid = 0
                        }
                    )
                ]

            else
                []

        _ ->
            []


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel mainMsg comMsg gameGlobalData _ ( model, t ) =
    case mainMsg of
        Tick _ ->
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

        _ ->
            case comMsg of
                GameInterCollisionMsg "player" _ _ ->
                    let
                        uid =
                            dgetint model.extra "TriggerUID"
                    in
                    ( { model | status = Dead t }, [ GameActorUidMsg uid (GameStringMsg "start") ], gameGlobalData )

                _ ->
                    ( model, [], gameGlobalData )
