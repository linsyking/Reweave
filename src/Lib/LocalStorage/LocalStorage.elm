module Lib.LocalStorage.LocalStorage exposing
    ( decodeLSInfo
    , encodeLSInfo
    )

{-| This is the doc for this module

@docs decodeLSInfo

@docs encodeLSInfo

-}

import Base exposing (LSInfo)
import Dict
import Json.Decode as Decode
import Json.Encode as Encode


{-| decodeLSInfo
-}
decodeLSInfo : String -> LSInfo
decodeLSInfo info =
    let
        decodeJSON =
            Decode.decodeString (Decode.dict (Decode.list Decode.string)) info

        resultJSOND =
            case decodeJSON of
                Ok res ->
                    res

                _ ->
                    Dict.empty

        oldcol =
            Maybe.withDefault [] (Dict.get "collected" resultJSOND)

        oldlevels =
            Maybe.withDefault [] (Dict.get "level" resultJSOND)

        oldlevel =
            Maybe.withDefault "Level0" (List.head oldlevels)
    in
    LSInfo oldcol oldlevel


{-| encodeLSInfo
-}
encodeLSInfo : LSInfo -> String
encodeLSInfo info =
    Encode.encode 0
        (Encode.dict identity
            (Encode.list Encode.string)
            (Dict.fromList
                [ ( "collected", info.collected )
                , ( "level", [ info.level ] )
                ]
            )
        )
