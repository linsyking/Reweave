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


changeCameraPositionHelper : Int -> GActor -> AbleDel -> Bool -> Float -> Float -> Int -> Int
changeCameraPositionHelper posCam char ableDel dir lineLow lineUp length =
    let
        ( pos, _ ) =
            getActorPosition char

        posX =
            pos.x - posCam

        posY =
            pos.y - posCam
    in
    if dir == True then
        Debug.log ("DirX " ++ String.fromInt posX) posCam + minAbleDel ableDel.left ableDel.right (moveFunctionHelper moveFunction (shouldDel posX (lineLow * toFloat length) (lineUp * toFloat length)))

    else
        Debug.log ("DirY " ++ String.fromInt posY) posCam + minAbleDel ableDel.up ableDel.down (moveFunctionHelper moveFunction (shouldDel posY (lineLow * toFloat length) (lineUp * toFloat length)))


minAbleDel : Int -> Int -> Int -> Int
minAbleDel l r del =
    if del < 0 then
        Debug.log ("minAbleDel " ++ String.fromInt del ++ " " ++ String.fromInt -l) round (max (toFloat -l) (toFloat del))

    else if del > 0 then
        Debug.log ("minAbleDel " ++ String.fromInt del ++ " " ++ String.fromInt r) round (min (toFloat r) (toFloat del))

    else
        0


shouldDel : Int -> Float -> Float -> Float
shouldDel pos l r =
    if toFloat pos < l then
        Debug.log ("shouldDel <" ++ String.fromInt pos ++ " " ++ String.fromFloat l ++ " " ++ String.fromFloat r) (toFloat pos - l)

    else if toFloat pos <= r then
        Debug.log ("shouldDel []" ++ String.fromInt pos ++ " " ++ String.fromFloat l ++ " " ++ String.fromFloat r) 0

    else
        Debug.log ("shouldDel >" ++ String.fromInt pos ++ " " ++ String.fromFloat l ++ " " ++ String.fromFloat r) (toFloat pos - r)


moveFunctionHelper : MoveFunction -> Float -> Int
moveFunctionHelper f del =
    if del > -f.b && del < f.b then
        round (1.0 * del)

    else if del > f.b then
        round f.b

    else
        round -f.b


changeGActorDisplay : Model -> Model
changeGActorDisplay model =
    let
        actors =
            toList model.actors

        camPos =
            model.cameraPosition
    in
    Debug.log ("Camera: " ++ String.fromInt camPos.x ++ " " ++ String.fromInt camPos.y)
        { model | actors = Array.fromList (changeGActorDisplayHelper actors camPos) }


changeGActorDisplayHelper : List GActor -> Position -> List GActor
changeGActorDisplayHelper list camPos =
    List.map (checkInbound camPos) list


checkInbound : Position -> GActor -> GActor
checkInbound camPos gActor =
    let
        ( posLU, posRD ) =
            getActorPosition gActor
    in
    if insideCam camPos posLU == True && insideCam camPos posRD == True then
        { gActor | show = Display }

    else
        { gActor | show = Hidden }


insideCam : Position -> Position -> Bool
insideCam posCam pos =
    if posCam.x <= pos.x && pos.x <= posCam.x + cameraWidth then
        True

    else if posCam.y <= pos.y && pos.y <= posCam.y + cameraHeight then
        True

    else
        False
