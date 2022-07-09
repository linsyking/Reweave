module Lib.CoreEngine.Camera.Camera exposing (..)


type alias MoveFunction =
    { a : Float, b : Float }


type alias AbleDel =
    { up : Int, down : Int, left : Int, right : Int }


type alias Position =
    { x : Int, y : Int }


reproducePosition : ( Int, Int ) -> Position
reproducePosition pos =
    Position (Tuple.first pos) (Tuple.second pos)


getCamera : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
getCamera camPos charPos1 charPos2 =
    let
        tmpPos =
            changeCameraPosition (reproducePosition camPos) (reproducePosition charPos1) (reproducePosition charPos2)
    in
    ( Tuple.first tmpPos, Tuple.second tmpPos )


cameraWidth : Int
cameraWidth =
    1920


cameraHeight : Int
cameraHeight =
    1080


moveFunction : MoveFunction
moveFunction =
    MoveFunction 0.001 10


changeCameraPosition : Position -> Position -> Position -> Position
changeCameraPosition camPos charPos _ =
    let
        -- Map Size
        ( sizeX, sizeY ) =
            ( 10000, 1020 )

        ableDel =
            makeAbleDel camPos.y (sizeY - camPos.y - cameraHeight) camPos.x (sizeX - camPos.x - cameraWidth)
    in
    Position (changeCameraPositionHelper camPos.x charPos ableDel True 0.2 0.6 cameraWidth) (changeCameraPositionHelper camPos.y char ableDel False 0.25 0.75 cameraHeight)


makeAbleDel : Int -> Int -> Int -> Int -> AbleDel
makeAbleDel a b c d =
    AbleDel (max a 0) (max b 0) (max c 0) (max d 0)


changeCameraPositionHelper : Int -> Position -> AbleDel -> Bool -> Float -> Float -> Int -> Int
changeCameraPositionHelper posCam charPos ableDel dir lineLow lineUp length =
    let
        pos =
            charPos

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
