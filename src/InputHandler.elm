module InputHandler exposing (..)

import Array exposing (..)
import Collision exposing (..)
import Common exposing (..)
import Math.Vector2 exposing (Vec2, getX, getY, vec2)



-- Function Type y=ax^2+bx+c


type alias DelVelocityFunction =
    { funcA : Float
    , funcB : Float
    , funcC : Float
    }


pressedVelocityFunction : DelVelocityFunction
pressedVelocityFunction =
    DelVelocityFunction (1 / 320.0) -0.75 40


oppositeVelocityFunction : DelVelocityFunction
oppositeVelocityFunction =
    DelVelocityFunction (-1 / 640.0) -0.25 -10


blankVelocityFunction : DelVelocityFunction
blankVelocityFunction =
    DelVelocityFunction (-1 / 160.0) 0 0


jumpPressedVelocityFunction : DelVelocityFunction
jumpPressedVelocityFunction =
    DelVelocityFunction (1 / 1280.0) -0.3125 20


jumpOppositeVelocityFunction : DelVelocityFunction
jumpOppositeVelocityFunction =
    DelVelocityFunction (-1 / 640.0) -0.125 -10


jumpBlankVelocityFunction : DelVelocityFunction
jumpBlankVelocityFunction =
    DelVelocityFunction (-1 / 460.0) 0 0


changePlayerVelocity : Model -> Model
changePlayerVelocity model =
    let
        character =
            get 0 model.actors
    in
    case character of
        Nothing ->
            model

        -- No actors
        Just char ->
            let
                space =
                    model.currentKeys.space

                curTime =
                    model.currentTime
            in
            if space == 0 then
                if canJump char model == False then
                    changePlayerVelocityHelper model (boundXY (changePlayerVelocityX model Ydir) char.velocity)

                else
                    changePlayerVelocityHelper model (boundXY (changePlayerVelocityX model Xdir) char.velocity)

            else if space == 1 then
                case model.keyPressed of
                    PressTime time ->
                        if curTime - time <= 20 then
                            changePlayerVelocityHelper model (boundXY (changePlayerVelocityX model Ydir) (changePlayerVelocityY model 2))

                        else if canJump char model == False then
                            changePlayerVelocityHelper { model | keyPressed = Nope } (boundXY (changePlayerVelocityX model Ydir) char.velocity)

                        else
                            changePlayerVelocityHelper { model | keyPressed = Nope } (boundXY (changePlayerVelocityX model Xdir) char.velocity)

                    Nope ->
                        changePlayerVelocityHelper { model | keyPressed = PressTime curTime } (boundXY (changePlayerVelocityX model Ydir) (changePlayerVelocityY model 1))

            else if canJump char model == False then
                changePlayerVelocityHelper { model | keyPressed = Nope } (boundXY (changePlayerVelocityX model Ydir) char.velocity)

            else
                changePlayerVelocityHelper { model | keyPressed = Nope } (boundXY (changePlayerVelocityX model Xdir) char.velocity)


type VelDirMsg
    = Xdir
    | Ydir


type VelTypeMsg
    = Pressed VelDirMsg Float
    | Opposite VelDirMsg Float
    | Blank VelDirMsg Float
    | UnKnown VelDirMsg Float



-- Change his velocity here
-- Player is the first element in the actors
-- You can use `isRiding to test if the object is riding on something or in the sky`


delVelocityFunction : DelVelocityFunction -> Float -> Float
delVelocityFunction f vel =
    let
        delVel =
            if vel <= 8 && vel > 0 then
                -vel

            else if vel >= -8 && vel < 0 then
                vel

            else
                toFloat (round (f.funcA * vel * vel + f.funcB * vel + f.funcC))

        newVel =
            vel + delVel
    in
    if newVel <= 8 && newVel >= -8 then
        -vel

    else
        delVel


changePlayerVelocityX : Model -> VelDirMsg -> Vec2
changePlayerVelocityX model dir =
    let
        left =
            model.currentKeys.left

        right =
            model.currentKeys.right

        char =
            getPlayer model

        charVelocity =
            char.velocity

        signX =
            sign (getX charVelocity)
    in
    if left == 0 then
        if right == 0 then
            delVelocityFunctionHelper charVelocity (Blank dir 0)

        else if right == 1 then
            if signX >= 0 then
                delVelocityFunctionHelper charVelocity (Pressed dir 1)

            else
                delVelocityFunctionHelper charVelocity (Opposite dir 0)

        else
            charVelocity

    else if left == 1 then
        if right == 0 then
            if signX > 0 then
                delVelocityFunctionHelper charVelocity (Opposite dir 0)

            else
                delVelocityFunctionHelper charVelocity (Pressed dir -1)

        else if right == 1 then
            charVelocity

        else
            charVelocity

    else if right == 0 then
        charVelocity

    else if right == 1 then
        if signX >= 0 then
            delVelocityFunctionHelper charVelocity (Pressed dir 1)

        else
            delVelocityFunctionHelper charVelocity (Opposite dir 0)

    else
        charVelocity


changePlayerVelocityY : Model -> Int -> Vec2
changePlayerVelocityY model flag =
    let
        char =
            getPlayer model

        charVelocity =
            char.velocity

        vecX =
            getX charVelocity

        vecY =
            getY charVelocity
    in
    case flag of
        1 ->
            Debug.log ("Jump+80:" ++ String.fromFloat (vecY + 160)) vec2 vecX (vecY + 160)

        2 ->
            Debug.log ("Jump+5:" ++ String.fromFloat (vecY + 3)) vec2 vecX (vecY + 3)

        _ ->
            charVelocity


changePlayerVelocityHelper : Model -> Vec2 -> Model
changePlayerVelocityHelper model vec =
    let
        char =
            getPlayer model
    in
    Debug.log (String.fromFloat (getX vec) ++ " " ++ String.fromFloat (getY vec) ++ " " ++ String.fromInt model.currentKeys.space) setPlayer { char | velocity = vec } model


delVelocityFunctionHelper : Vec2 -> VelTypeMsg -> Vec2
delVelocityFunctionHelper vec velTypeMsg =
    let
        vecX =
            getX vec

        signX =
            toFloat (sign vecX)

        vecY =
            getY vec

        signY =
            toFloat (sign vecY)
    in
    case velTypeMsg of
        Pressed msgDir x ->
            case msgDir of
                Xdir ->
                    vec2 (x * (abs vecX + delVelocityFunction pressedVelocityFunction (abs vecX))) vecY

                Ydir ->
                    vec2 (x * (abs vecX + delVelocityFunction jumpPressedVelocityFunction (abs vecX))) vecY

        Blank msgDir _ ->
            case msgDir of
                Xdir ->
                    vec2 (signX * (abs vecX + delVelocityFunction blankVelocityFunction (abs vecX))) vecY

                Ydir ->
                    vec2 (signX * (abs vecX + delVelocityFunction jumpBlankVelocityFunction (abs vecX))) vecY

        Opposite msgDir _ ->
            case msgDir of
                Xdir ->
                    vec2 (signX * (abs vecX + delVelocityFunction oppositeVelocityFunction (abs vecX))) vecY

                Ydir ->
                    vec2 (signX * (abs vecX + delVelocityFunction jumpOppositeVelocityFunction (abs vecX))) vecY

        UnKnown _ _ ->
            vec2 vecX vecY


boundXY : Vec2 -> Vec2 -> Vec2
boundXY xDir yDir =
    vec2 (getX xDir) (getY yDir)


sign : Float -> Int
sign x =
    if x > 0 then
        1

    else if x < 0 then
        -1

    else
        0
