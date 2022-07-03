module Lib.DefinedTypes.Base exposing (..)

import Lib.CoreEngine.GameComponents.Player.Base as PlayerBase


type DefinedTypes
    = CDInt Int
    | CDBool Bool
    | CDFloat Float
    | CDString String
    | CDLString (List String)
    | CDPlayerModel PlayerBase.Model
