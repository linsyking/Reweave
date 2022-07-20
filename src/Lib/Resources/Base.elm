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
    , ( "blueshadow", getResourcePath "img/ki.png" )
    , ( "p_jump", getResourcePath "img/p_jump.png" )
    , ( "p_stand", getResourcePath "img/p_stand.png" )
    , ( "p_fall", getResourcePath "img/p_fall.png" )
    , ( "p_m1", getResourcePath "img/p_m1.png" )
    , ( "p_m2", getResourcePath "img/p_m2.png" )
    , ( "p_m3", getResourcePath "img/p_m3.png" )
    , ( "p_m4", getResourcePath "img/p_m4.png" )
    , ( "p_m5", getResourcePath "img/p_m5.png" )
    , ( "p_m6", getResourcePath "img/p_m6.png" )
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
