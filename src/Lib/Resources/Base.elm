module Lib.Resources.Base exposing (..)

import Base exposing (Msg(..))
import Canvas.Texture as Texture exposing (Texture)
import Dict exposing (Dict)


getResourcePath : String -> String
getResourcePath x =
    "assets/" ++ x


allTexture : List ( String, String )
allTexture =
    [ ( "background", getResourcePath "img/bg.jpg" )
    ]


getTexture : List (Texture.Source Msg)
getTexture =
    List.map (\( x, y ) -> Texture.loadFromImageUrl y (TextureLoaded x)) allTexture


saveSprite : Dict String Texture -> String -> Texture -> Dict String Texture
saveSprite dst name text =
    Dict.insert name text dst


getSprite : String -> Dict String Texture -> Maybe Texture
getSprite name dst =
    Dict.get name dst
