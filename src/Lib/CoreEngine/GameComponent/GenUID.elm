module Lib.CoreEngine.GameComponent.GenUID exposing (..)

{-| This is the doc for this module

@docs genUID

-}

import Array
import Lib.CoreEngine.GameLayer.Common exposing (Model)



-- Generate available UID


{-| genUID
-}
genUID : Model -> Int
genUID model =
    let
        actorsUID =
            Array.map (\x -> x.data.uid)
                model.actors
    in
    case List.maximum (Array.toList actorsUID) of
        Just x ->
            x + 1

        Nothing ->
            99999
