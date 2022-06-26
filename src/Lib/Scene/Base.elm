module Lib.Scene.Base exposing (..)

import Base exposing (GlobalData, Msg)
import Html exposing (Html, div)


type alias Scene a =
    { init : Int -> SceneMsg -> a
    , update : Msg -> ( a, Int ) -> ( a, SceneOutputMsg )
    , view : ( a, Int ) -> GlobalData -> Html Msg
    }


nullScene : Scene Bool
nullScene =
    { init = \_ _ -> True
    , update = \_ ( x, _ ) -> ( x, NullSceneOutputMsg )
    , view = \_ _ -> div [] []
    }


type SceneMsg
    = SceneStringMsg String
    | SceneIntMsg Int
    | NullSceneMsg


type SceneOutputMsg
    = ChangeScene ( SceneMsg, String )
    | PlaySound String
    | SetSound Float
    | NullSceneOutputMsg
