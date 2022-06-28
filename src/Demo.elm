module Demo exposing (..)

-- import Array
-- import Array2D
-- import Math.Vector2 exposing (vec2)
-- import Time
-- import Math.Matrix4 as Mat4 exposing (Mat4)
-- import Math.Vector3 exposing (Vec3, vec3)

import Acceleration exposing (addAcc)
import Browser
import Browser.Events exposing (onKeyDown, onKeyUp)
import Common exposing (..)
import Draw exposing (drawG)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import InputFilter exposing (preCheck)
import InputHandler exposing (changePlayerVelocity)
import Json.Decode as Decode
import Movement exposing (playerMove)
import StatesControl exposing (stateControl)
import Time


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



--INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel, Cmd.none )



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            let
                --- First change time
                mde =
                    { model | currentTime = model.currentTime + 1 }

                --- State change
                cst =
                    stateControl mde

                mdep =
                    preCheck cst

                --- Second change player velocity according to input
                changedPVM =
                    changePlayerVelocity mdep

                --- Third change velocity according to accecleration
                changedAcc =
                    addAcc changedPVM

                --- Next Move Objects (Now only player)
                pMM =
                    playerMove changedAcc

                aMM =
                    afterMove pMM

                -- Delete Releasing Keys
            in
            ( aMM, Cmd.none )

        KeyDown tp ->
            let
                newmodel =
                    { model | originKeys = changebk tp 1 model.originKeys }
            in
            ( newmodel, Cmd.none )

        KeyUp tp ->
            let
                newmodel =
                    { model | originKeys = changebk tp 0 model.originKeys }
            in
            ( newmodel, Cmd.none )



--SUBSCRIBE


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Time.every 15 Tick --- Slow down the fps
        , onKeyDown (Decode.map keyDownConverter (Decode.field "keyCode" Decode.int))
        , onKeyUp (Decode.map keyUpConverter (Decode.field "keyCode" Decode.int))
        ]



--VIEW


view : Model -> Html Msg
view model =
    div
        [ style "width" "100%"
        , style "height" "100%"
        , style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        ]
        [ renderGame model ]


renderGame : Model -> Html Msg
renderGame model =
    drawG model
