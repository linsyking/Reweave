module Lib.Resources.Base exposing (..)


getResourcePath : String -> String
getResourcePath x =
    "assets/" ++ x
