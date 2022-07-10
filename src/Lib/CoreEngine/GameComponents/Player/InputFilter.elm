module Lib.CoreEngine.GameComponents.Player.InputFilter exposing (..)

import Lib.CoreEngine.GameComponents.Player.Base exposing (Model, SpaceLog(..))
import Lib.CoreEngine.GameComponents.Player.FSM exposing (queryIsState)



--- Filter input


isNope : Model -> Bool
isNope model =
    case model.keyPressed of
        Nope ->
            True

        _ ->
            False


isFirstJump : Model -> Bool
isFirstJump model =
    if model.lastOriginKeys.space == 0 && model.originKeys.space == 1 then
        True

    else
        False


afterMove : Model -> Model
afterMove model =
    --- Copy current keys to backup
    { model | lastOriginKeys = model.originKeys }


preCheck : Int -> Model -> Model
preCheck t model =
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

        -- delta = Debug.log "delta" (model.jStartTime)
        nspace =
            if cs == 1 then
                if queryIsState model "inair" && not (isNope model) then
                    1

                else if queryIsState model "onground" && t - jst <= 15 then
                    1

                else
                    0

            else
                cs

        mok =
            Debug.log "originkey" model.originKeys

        newkeys =
            Debug.log "NewKeys" { mok | space = nspace }
    in
    { model | jStartTime = jst, currentKeys = newkeys }
