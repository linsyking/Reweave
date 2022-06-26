module Scenes.Scene1.Layer1.Display exposing (..)

import Base exposing (..)
import Html exposing (..)
import Lib.Coordinate.Coordinates exposing (..)
import Scenes.Scene1.Layer1.Common exposing (..)
import Scenes.Scene1.LayerBase exposing (CommonData)


dview : SModel -> CommonData -> GlobalData -> Html Msg
dview ( _, _ ) _ _ =
    div
        []
        [ text "Hi" ]
