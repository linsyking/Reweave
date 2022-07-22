module Lib.CoreEngine.GameComponents.Player.InputFilter exposing (..)

{-| This is the doc for this module

@docs isNope

@docs isFirstJump

@docs afterMove

@docs preCheck

@docs judgeFirstJump

-}

import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model, SpaceLog(..))
import Lib.CoreEngine.GameComponents.Player.FSM exposing (queryIsState, queryStateStarttime)



--- Filter input


{-| isNope
-}
isNope : Model -> Bool
isNope model =
    case model.keyPressed of
        Nope ->
            True

        _ ->
            False


{-| isFirstJump
-}
isFirstJump : Model -> Bool
isFirstJump model =
    if model.lastOriginKeys.space == 0 && model.originKeys.space == 1 then
        True

    else
        False


{-| afterMove
-}
afterMove : Model -> Model
afterMove model =
    --- Copy current keys to backup
    { model | lastOriginKeys = model.originKeys }


{-| preCheck
-}
preCheck : Int -> Model -> Data -> ( Model, Data )
preCheck t model d =
    let
        --- First Update Space
        cs =
            model.originKeys.space

        jst =
            if isFirstJump model then
                --- First Press
                t

            else
                model.jStartTime

        stt =
            queryStateStarttime model "inair"

        nspace =
            if cs == 1 then
                if queryIsState model "inair" && not (isNope model) then
                    1

                else if queryIsState model "onground" && t - jst <= 10 then
                    1

                else if iswolfJump then
                    1

                else
                    0

            else
                cs

        iswolfJump =
            cs == 1 && queryIsState model "inair" && t - stt <= 10 && isNope model && t - jst <= 10

        newd =
            if iswolfJump then
                let
                    ( vx, _ ) =
                        d.velocity
                in
                { d | velocity = ( vx, 0 ) }

            else
                d

        mok =
            model.originKeys

        newkeys =
            { mok | space = nspace }
    in
    ( { model | jStartTime = jst, currentKeys = newkeys }, newd )


{-| judgeFirstJump
-}
judgeFirstJump : Int -> Model -> Data -> Bool
judgeFirstJump t model _ =
    let
        cs =
            model.originKeys.space

        jst =
            if isFirstJump model then
                --- First Press
                t

            else
                model.jStartTime

        stt =
            queryStateStarttime model "inair"

        nspace =
            if cs == 1 then
                if queryIsState model "inair" && not (isNope model) then
                    1

                else if queryIsState model "onground" && t - jst <= 10 then
                    1

                else if iswolfJump then
                    1

                else
                    0

            else
                cs

        iswolfJump =
            cs == 1 && queryIsState model "inair" && t - stt <= 10 && isNope model && t - jst <= 10
    in
    (isFirstJump model && nspace == 1 && isNope model) || (queryIsState model "onground" && t - jst <= 10 && cs == 1 && t - jst >= 1)
