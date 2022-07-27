module Lib.LocalStorage.LocalStorage exposing
    ( decodeLSInfo
    , encodeLSInfo
    , isFirstPlay
    )

{-| This is the doc for this module

@docs decodeLSInfo

@docs encodeLSInfo

@docs isFirstPlay

-}

import Base exposing (LSInfo)
import Json.Decode as Decode exposing (at, decodeString)
import Json.Encode as Encode


{-| decodeLSInfo
-}
decodeLSInfo : String -> LSInfo
decodeLSInfo info =
    let
        oldcol =
            Result.withDefault [] (decodeString (at [ "collected" ] (Decode.list Decode.string)) info)

        oldlevel =
            Result.withDefault "" (decodeString (at [ "level" ] Decode.string) info)

        oldenergy =
            Result.withDefault 0 (decodeString (at [ "energy" ] Decode.float) info)

        oldposx =
            Result.withDefault -1 (decodeString (at [ "posx" ] Decode.int) info)

        oldposy =
            Result.withDefault -1 (decodeString (at [ "posy" ] Decode.int) info)

        oldvol =
            Result.withDefault 50 (decodeString (at [ "volume" ] Decode.float) info)
    in
    LSInfo oldcol oldlevel oldenergy ( oldposx, oldposy ) oldvol


{-| encodeLSInfo
-}
encodeLSInfo : LSInfo -> String
encodeLSInfo info =
    let
        ( x, y ) =
            info.initPosition
    in
    Encode.encode 0
        (Encode.object
            [ ( "collected", Encode.list Encode.string info.collected )
            , ( "level", Encode.string info.level )
            , ( "energy", Encode.float info.energy )
            , ( "posx", Encode.int x )
            , ( "posy", Encode.int y )
            , ( "volume", Encode.float info.volume )
            ]
        )


{-| isFirstPlay
-}
isFirstPlay : LSInfo -> Bool
isFirstPlay ls =
    (ls.level == "" && ls.collected == []) || ls.level == "Home"



-- collectMonster: List String -> String -> List String
-- collectMonster ls s =
