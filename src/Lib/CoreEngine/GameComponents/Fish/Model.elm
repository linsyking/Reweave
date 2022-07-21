module Lib.CoreEngine.GameComponents.Fish.Model exposing (..)

-- import Lib.CoreEngine.Physics.Velocity exposing (changeCVel)

import Base exposing (GlobalData, Msg(..))
import Dict
import Lib.Component.Base exposing (DefinedTypes(..))
import Lib.Coordinate.Coordinates exposing (judgeMouse)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.Camera.Position exposing (getPositionUnderCamera)
import Lib.CoreEngine.GameComponent.Base exposing (Box, Data, GameComponentMsgType(..), GameComponentTMsg(..), LifeStatus(..))
import Lib.CoreEngine.GameComponents.Bullet.Base exposing (BulletInit)
import Lib.DefinedTypes.Parser exposing (dgetString, dgetint, dsetint, dsetstring)


initData : Data
initData =
    { status = Alive
    , position = ( 100, 1500 )
    , velocity = ( 0, 0 )
    , mass = 70
    , acceleration = ( 0, -8 )
    , simplecheck = simplecheckBox
    , collisionbox = [ collisionBox, reboundBox ]
    , extra = Dict.empty
    , uid = 2
    }


collisionBox : Box
collisionBox =
    { name = "col"
    , offsetX = 0
    , offsetY = 11
    , width = 600
    , height = 500
    }


reboundBox : Box
reboundBox =
    { name = "reb"
    , offsetX = 0
    , offsetY = 0
    , width = 600
    , height = 490
    }


simplecheckBox : Box
simplecheckBox =
    { name = "sp"
    , offsetX = 0
    , offsetY = 0
    , width = 600
    , height = 600
    }


initModel : Int -> GameComponentTMsg -> Data
initModel _ comMsg =
    case comMsg of
        GameFishInit info ->
            { status = Alive
            , position = info.initPosition
            , velocity = info.initVelocity
            , mass = 70
            , acceleration = ( 0, 0 )
            , simplecheck = simplecheckBox
            , collisionbox = [ collisionBox, reboundBox ]
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
        ( "Away", 1200 ) ->
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

        ( "FlyHigh", 300 ) ->
            { model
                | extra =
                    data
                        |> dsetstring "Status" "Hide"
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
        "FlyHigh" ->
            if timer < 100 then
                { model | velocity = ( -15, 5 ) }

            else
                { model | velocity = ( 15, 5 ) }

        _ ->
            model


getInitBulletsMsg : Data -> List GameComponentMsgType
getInitBulletsMsg model =
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
                                        , uid = 0
                                        }
                                    )
                                ]
                            , index + 18
                            )
                        )
                        ( [], 0 )
                        (List.repeat 20 ( Tuple.first model.position + 300, Tuple.second model.position + 300 ))
                    )

            else
                []

        _ ->
            []


updateModel : Msg -> GameComponentTMsg -> GameGlobalData -> GlobalData -> ( Data, Int ) -> ( Data, List GameComponentMsgType, GameGlobalData )
updateModel mainMsg comMsg gameGlobalData globalData ( model, t ) =
    case mainMsg of
        Tick _ ->
            let
                requestMsg =
                    getInitBulletsMsg model

                newModel =
                    model
                        |> changeStatus
                        |> changeVelocity
            in
            ( newModel, requestMsg, gameGlobalData )

        MouseDown 0 mp ->
            if judgeMouse globalData mp (getPositionUnderCamera model.position gameGlobalData) ( model.simplecheck.width, model.simplecheck.height ) then
                ( model, [], { gameGlobalData | selectobj = model.uid } )

            else
                ( model, [], gameGlobalData )

        _ ->
            case comMsg of
                GameClearVelocity ->
                    ( { model | velocity = ( 0, 0 ) }, [], gameGlobalData )

                -- GameUseEnergy mp e ->
                --     let
                --         ndd =
                --             changeCVel d mp e
                --     in
                --     ( ndd, [], ggd )
                -- GameStringMsg "die" ->
                --     ( { d | status = Dead t }, [], ggd )
                _ ->
                    ( model, [], gameGlobalData )
