module Lib.CoreEngine.GameComponents.Player.Base exposing (..)


type alias PlayerInit =
    { initPosition : ( Int, Int )
    }


type SpaceLog
    = PressTime Int
    | Nope


type alias StateData =
    { stype : String
    , starttime : Int
    }


type PlayerState
    = PlayerStates (List StateData)


type alias BoundKey =
    { left : Int
    , right : Int
    , up : Int
    , down : Int
    , space : Int
    }


type alias Model =
    { currentKeys : BoundKey
    , originKeys : BoundKey
    , keyPressed : SpaceLog
    , jStartTime : Int
    , playerStates : PlayerState
    , lastOriginKeys : BoundKey
    }


nullModel : Model
nullModel =
    { currentKeys = BoundKey 0 0 0 0 0
    , keyPressed = Nope
    , jStartTime = 0
    , originKeys = BoundKey 0 0 0 0 0
    , playerStates = PlayerStates []
    , lastOriginKeys = BoundKey 0 0 0 0 0
    }


changebk : Int -> Int -> BoundKey -> BoundKey
changebk key status bk =
    case key of
        65 ->
            { bk | left = status }

        68 ->
            { bk | right = status }

        67 ->
            { bk | space = status }

        _ ->
            bk
