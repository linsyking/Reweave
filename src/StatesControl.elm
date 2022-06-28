module StatesControl exposing (..)

import Collision exposing (..)
import Common exposing (..)
import FSM exposing (..)



--- States Controller


stateControl : Model -> Model
stateControl model =
    let
        changecurrent : State -> Model -> Model
        changecurrent state md =
            if state.ifExit md then
                exitState md state.key

            else
                state.doing md

        model2 =
            List.foldl changecurrent model (getPlayerStates model)

        addcurrent : ( State, Model -> Bool ) -> Model -> Model
        addcurrent ( st, cu ) md =
            if cu md && not (queryIsState md st.key) then
                addState md st.key

            else
                md

        model3 =
            List.foldl addcurrent model2 (allStates model2)

        updatecurrent : State -> Model -> Model
        updatecurrent state md =
            state.doing md

        newmodel =
            List.foldl updatecurrent model3 (getPlayerStates model3)
    in
    newmodel


initStates : Model -> Model
initStates model =
    model
