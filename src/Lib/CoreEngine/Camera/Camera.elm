module Lib.CoreEngine.Camera.Camera exposing (..)


getCamera : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
getCamera _ _ _ =
    ( 0, 0 )


type alias MoveFunction =
    { a : Float, b : Float }


type alias AbleDel =
    { up : Int, down : Int, left : Int, right : Int }


cameraWidth : Int
cameraWidth =
    1024


cameraHeight : Int
cameraHeight =
    1024 // 16 * 9


moveFunction : MoveFunction
moveFunction =
    MoveFunction 0.001 10


cameraProcess : Model -> Model
cameraProcess model =
    model
        |> changeCameraPosition
        |> changeGActorDisplay


changeCameraPosition : Model -> Model
changeCameraPosition model =
    let
        char =
            getPlayer model

        camPos =
            model.cameraPosition

        ( sizeX, sizeY ) =
            getMapSize model

        ableDel =
            makeAbleDel camPos.y (sizeY - camPos.y - cameraHeight) camPos.x (sizeX - camPos.x - cameraWidth)
    in
    { model | cameraPosition = Position (changeCameraPositionHelper camPos.x char ableDel True 0.2 0.6 cameraWidth) (changeCameraPositionHelper camPos.y char ableDel False 0.25 0.75 cameraHeight) }


makeAbleDel : Int -> Int -> Int -> Int -> AbleDel
makeAbleDel a b c d =
    AbleDel (max a 0) (max b 0) (max c 0) (max d 0)
