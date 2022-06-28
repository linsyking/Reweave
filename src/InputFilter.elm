module InputFilter exposing (..)

import Collision exposing (..)
import Common exposing (..)
import FSM exposing (queryIsState)



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


preCheck : Model -> Model
preCheck model =
    let
        --- First Update Space
        cs =
            model.originKeys.space

        jst =
            if isFirstJump model then
                --- First Press
                model.currentTime

            else
                model.jStartTime

        -- delta = Debug.log "delta" (model.jStartTime)
        nspace =
            if cs == 1 then
                if queryIsState model "inair" && not (isNope model) then
                    1

                else if queryIsState model "onground" && model.currentTime - jst <= 15 then
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
