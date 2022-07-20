module Lib.Resources.Base exposing (..)

import Base exposing (Msg(..))
import Canvas exposing (text)
import Canvas.Texture as Texture exposing (Texture)
import Dict exposing (Dict)


getResourcePath : String -> String
getResourcePath x =
    "assets/" ++ x


allTexture : List ( String, String )
allTexture =
    [ ( "background", getResourcePath "img/bg.jpg" )
    , ( "rcloud", getResourcePath "img/rcloud.png" )
    , ( "lcloud", getResourcePath "img/lcloud.png" )
    , ( "bricksheet", getResourcePath "img/bricks.png" )
    , ( "spikeL", getResourcePath "img/spikeL.png" )
    , ( "spikeR", getResourcePath "img/spikeR.png" )
    , ( "spikeT", getResourcePath "img/spikeT.png" )
    , ( "spikeB", getResourcePath "img/spikeB.png" )
    , ( "dialogue", getResourcePath "img/dialogue.png" )
    , ( "downbutton", getResourcePath "img/down.png" )
    , ( "bullet", getResourcePath "img/bullet.png" )
    , ( "fish", getResourcePath "img/fish.png" )
    , ( "whiteshadow", getResourcePath "img/white-shadow.png" )
    , ( "blueshadow", getResourcePath "img/ki2.png" )
    ]


getTexture : List (Texture.Source Msg)
getTexture =
    List.map (\( x, y ) -> Texture.loadFromImageUrl y (TextureLoaded x)) allTexture


saveSprite : Dict String Texture -> String -> Texture -> Dict String Texture
saveSprite dst name text =
    Dict.insert name text dst


igetSprite : String -> Dict String Texture -> Maybe Texture
igetSprite name dst =
    Dict.get name dst
