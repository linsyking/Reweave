module Lib.CoreEngine.GameComponents.Player.StatesControl exposing (..)

{-| This is the doc for this module

@docs stateControl

-}

import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model)
import Lib.CoreEngine.GameComponents.Player.Common exposing (State)
import Lib.CoreEngine.GameComponents.Player.FSM exposing (..)



--- States Controller


{-| stateControl
-}
stateControl : Int -> Model -> Data -> GameGlobalData -> ( Model, Data )
stateControl t model gc ggd =
    let
        changecurrent : ( State, Int ) -> Model -> Data -> ( Model, Data )
        changecurrent ( state, startt ) md ngc =
            if state.ifExit startt t md ngc ggd then
                exitState t md ngc ggd state.key

            else
                ( md, ngc )

        ( model2, gc2 ) =
            List.foldl (\loo ( nmm, ngcc ) -> changecurrent loo nmm ngcc) ( model, gc ) (getPlayerStates model)

        addcurrent : State -> Model -> Data -> ( Model, Data )
        addcurrent state md ngc =
            if state.ifEnter t md ngc ggd then
                addState t md ngc ggd state.key

            else
                ( md, ngc )

        allempty =
            getEmptyStates model2

        ( model3, gc3 ) =
            List.foldl (\xx ( nmm, ngcc ) -> addcurrent xx nmm ngcc) ( model2, gc2 ) allempty

        updatecurrent : ( State, Int ) -> Model -> Data -> ( Model, Data )
        updatecurrent ( state, _ ) md ngc =
            updateState t md ngc ggd state.key

        newmodel =
            List.foldl (\xx ( nmm, ngcc ) -> updatecurrent xx nmm ngcc) ( model3, gc3 ) (getPlayerStates model3)
    in
    newmodel
