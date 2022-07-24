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
import Dict
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
            Result.withDefault "Level0" (decodeString (at [ "level" ] Decode.string) info)
    in
    LSInfo oldcol oldlevel


{-| encodeLSInfo
-}
encodeLSInfo : LSInfo -> String
encodeLSInfo info =
    Encode.encode 0
        (Encode.object
            [ ( "collected", Encode.list Encode.string info.collected )
            , ( "level", Encode.string info.level )
            ]
        )


{-| isFirstPlay
-}
isFirstPlay : LSInfo -> Bool
isFirstPlay ls =
    ls.level == "Level0" && ls.collected == []
