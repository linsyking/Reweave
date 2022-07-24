module Lib.CoreEngine.GameComponents.Player.Base exposing
    ( SpaceLog(..)
    , PlayerState(..)
    , PlayerInitPosition(..)
    , PlayerInit
    , StateData
    , BoundKey
    , Model
    , nullModel
    , changebk
    , changehistory
    , fixnotrightdir
    )

{-| This is the doc for this module

@docs SpaceLog

@docs PlayerState

@docs PlayerInitPosition

@docs PlayerInit

@docs StateData

@docs BoundKey

@docs Model

@docs nullModel

@docs changebk

@docs changehistory

@docs fixnotrightdir

-}

import Json.Encode exposing (int)


{-| PlayerInit
-}
type alias PlayerInit =
    { initPosition : ( Int, Int )
    }


{-| SpaceLog
-}
type SpaceLog
    = PressTime Int
    | Nope


{-| StateData
-}
type alias StateData =
    { stype : String
    , starttime : Int
    }


{-| PlayerState
-}
type PlayerState
    = PlayerStates (List StateData)


{-| BoundKey
-}
type alias BoundKey =
    { left : Int
    , right : Int
    , up : Int
    , down : Int
    , space : Int
    }


{-| Model
-}
type alias Model =
    { currentKeys : BoundKey
    , originKeys : BoundKey
    , keyPressed : SpaceLog
    , jStartTime : Int
    , playerStates : PlayerState
    , lastOriginKeys : BoundKey
    , islastright : Bool
    , listPosition : List ( Int, Int, ( String, Int ) )
    , recordTimer : Int
    }


{-| nullModel
-}
nullModel : Model
nullModel =
    { currentKeys = BoundKey 0 0 0 0 0
    , keyPressed = Nope
    , jStartTime = -100
    , originKeys = BoundKey 0 0 0 0 0
    , playerStates = PlayerStates []
    , lastOriginKeys = BoundKey 0 0 0 0 0
    , islastright = True
    , listPosition = []
    , recordTimer = 0
    }


{-| changebk
-}
changebk : Int -> Int -> BoundKey -> BoundKey
changebk key status bk =
    case key of
        65 ->
            { bk | left = status }

        68 ->
            { bk | right = status }

        67 ->
            { bk | space = status }

        32 ->
            { bk | space = status }

        _ ->
            bk


{-| changehistory
-}
changehistory : Bool -> Int -> Bool
changehistory old key =
    case key of
        65 ->
            False

        68 ->
            True

        _ ->
            old


{-| fixnotrightdir
-}
fixnotrightdir : Bool -> BoundKey -> Bool
fixnotrightdir o bk =
    if bk.right == 1 && bk.left == 0 then
        True

    else if bk.right == 0 && bk.left == 1 then
        False

    else
        o


{-| PlayerInitPosition
-}
type PlayerInitPosition
    = DefaultPlayerPosition
    | CustomPlayerPosition ( Int, Int )
