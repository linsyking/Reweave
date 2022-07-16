module Lib.CoreEngine.GameComponents.Player.InputHandler exposing (..)

import Array exposing (..)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (Data)
import Lib.CoreEngine.GameComponents.Player.Base exposing (Model, SpaceLog(..))
import Lib.CoreEngine.Physics.Ground exposing (canJump)



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


changePlayerVelocity : Int -> Data -> GameGlobalData -> Model -> ( Model, Data )
changePlayerVelocity t char ggd model =
    let
        space =
            model.currentKeys.space

        curTime =
            t
    in
    if Tuple.first char.velocity > 80 then
        ( model, { char | velocity = ( Tuple.first char.velocity - 10.0, Tuple.second char.velocity ) } )

    else if space == 0 then
        if canJump char ggd == False then
            ( model, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Ydir) char.velocity) )

        else
            ( model, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Xdir) char.velocity) )

    else if space == 1 then
        case model.keyPressed of
            PressTime time ->
                if curTime - time <= 20 then
                    ( model, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Ydir) (changePlayerVelocityY char 2)) )

                else if canJump char ggd == False then
                    ( { model | keyPressed = Nope }, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Ydir) char.velocity) )

                else
                    ( { model | keyPressed = Nope }, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Xdir) char.velocity) )

            Nope ->
                ( { model | keyPressed = PressTime curTime }, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Ydir) (changePlayerVelocityY char 1)) )

    else if canJump char ggd == False then
        ( { model | keyPressed = Nope }, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Ydir) char.velocity) )

    else
        ( { model | keyPressed = Nope }, changePlayerVelocityHelper char (boundXY (changePlayerVelocityX char model Xdir) char.velocity) )


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


changePlayerVelocityX : Data -> Model -> VelDirMsg -> ( Float, Float )
changePlayerVelocityX char model dir =
    let
        left =
            model.currentKeys.left

        right =
            model.currentKeys.right

        charVelocity =
            char.velocity

        signX =
            sign (Tuple.first charVelocity)
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


changePlayerVelocityY : Data -> Int -> ( Float, Float )
changePlayerVelocityY char flag =
    let
        charVelocity =
            char.velocity

        ( vecX, vecY ) =
            charVelocity
    in
    case flag of
        1 ->
            ( vecX, vecY + 160 )

        2 ->
            ( vecX, vecY + 3 )

        _ ->
            charVelocity


changePlayerVelocityHelper : Data -> ( Float, Float ) -> Data
changePlayerVelocityHelper cd nv =
    { cd | velocity = nv }


delVelocityFunctionHelper : ( Float, Float ) -> VelTypeMsg -> ( Float, Float )
delVelocityFunctionHelper vec velTypeMsg =
    let
        ( vecX, vecY ) =
            vec

        signX =
            toFloat (sign vecX)

        -- signY =
        --     toFloat (sign vecY)
    in
    case velTypeMsg of
        Pressed msgDir x ->
            case msgDir of
                Xdir ->
                    ( x * (abs vecX + delVelocityFunction pressedVelocityFunction (abs vecX)), vecY )

                Ydir ->
                    ( x * (abs vecX + delVelocityFunction jumpPressedVelocityFunction (abs vecX)), vecY )

        Blank msgDir _ ->
            case msgDir of
                Xdir ->
                    ( signX * (abs vecX + delVelocityFunction blankVelocityFunction (abs vecX)), vecY )

                Ydir ->
                    ( signX * (abs vecX + delVelocityFunction jumpBlankVelocityFunction (abs vecX)), vecY )

        Opposite msgDir _ ->
            case msgDir of
                Xdir ->
                    ( signX * (abs vecX + delVelocityFunction oppositeVelocityFunction (abs vecX)), vecY )

                Ydir ->
                    ( signX * (abs vecX + delVelocityFunction jumpOppositeVelocityFunction (abs vecX)), vecY )

        UnKnown _ _ ->
            ( vecX, vecY )


boundXY : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
boundXY ( a, _ ) ( _, b ) =
    ( a, b )


sign : Float -> Int
sign x =
    if x > 0 then
        1

    else if x < 0 then
        -1

    else
        0
