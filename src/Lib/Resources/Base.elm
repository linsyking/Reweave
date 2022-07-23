module Lib.Resources.Base exposing
    ( getResourcePath
    , getTexture
    , saveSprite
    , igetSprite
    , allTexture
    )

{-| This is the doc for this module

@docs getResourcePath

@docs getTexture

@docs saveSprite

@docs igetSprite

@docs allTexture

-}

import Base exposing (Msg(..))
import Canvas exposing (text)
import Canvas.Texture as Texture exposing (Texture)
import Dict exposing (Dict)


{-| getResourcePath
-}
getResourcePath : String -> String
getResourcePath x =
    "assets/" ++ x


{-| getTexture
-}
getTexture : List (Texture.Source Msg)
getTexture =
    List.map (\( x, y ) -> Texture.loadFromImageUrl y (TextureLoaded x)) allTexture


{-| saveSprite
-}
saveSprite : Dict String Texture -> String -> Texture -> Dict String Texture
saveSprite dst name text =
    Dict.insert name text dst


{-| igetSprite
-}
igetSprite : String -> Dict String Texture -> Maybe Texture
igetSprite name dst =
    Dict.get name dst


{-| allTexture
-}
allTexture : List ( String, String )
allTexture =
    [ ( "background", getResourcePath "img/DongHai.jpg" )
    , ( "homepage", getResourcePath "img/homepage.jpg" )
    , ( "lcloud", getResourcePath "img/cloud.png" )
    , ( "spikeL", getResourcePath "img/spikeL.png" )
    , ( "spikeR", getResourcePath "img/spikeR.png" )
    , ( "spikeT", getResourcePath "img/spikeT.png" )
    , ( "spikeB", getResourcePath "img/spikeB.png" )
    , ( "blueshadow", getResourcePath "img/ki.png" )
    , ( "skull", getResourcePath "img/skull.png" )
    , ( "dialogue", getResourcePath "img/dialogue.png" )
    , ( "downbutton", getResourcePath "img/down.png" )
    , ( "bullet", getResourcePath "img/bullet.png" )
    , ( "whiteshadow", getResourcePath "img/white-shadow.png" )
    ]
        ++ charaSprites
        ++ beiminSprites
        ++ donghaiSprites
        ++ jiangnanSprites
        ++ longxiSprites
        ++ zhongyuanSprites
        ++ otherSprites
        ++ backgroundSprites
        ++ monsterSprites


monsterSprites : List ( String, String )
monsterSprites =
    [ ( "fish", getResourcePath "img/fish.png" )
    , ( "turtle", getResourcePath "img/turtle.png" )
    , ( "bird", getResourcePath "img/bird.png" )
    , ( "fox", getResourcePath "img/fox.png" )
    , ( "lion", getResourcePath "img/lion.png" )
    , ( "goomba", getResourcePath "img/small.png" )
    , ( "goombadie", getResourcePath "img/smalldie.png" )
    ]


{-| charaSprites
-}
charaSprites : List ( String, String )
charaSprites =
    [ ( "p_jump", getResourcePath "img/p_jump.png" )
    , ( "p_stand", getResourcePath "img/p_stand.png" )
    , ( "p_fall", getResourcePath "img/p_fall.png" )
    , ( "p_m1", getResourcePath "img/p_m1.png" )
    , ( "p_m2", getResourcePath "img/p_m2.png" )
    , ( "p_m3", getResourcePath "img/p_m3.png" )
    , ( "p_m4", getResourcePath "img/p_m4.png" )
    , ( "p_m5", getResourcePath "img/p_m5.png" )
    , ( "p_m6", getResourcePath "img/p_m6.png" )
    , ( "p_profile", getResourcePath "img/profile.png" )
    , ( "master", getResourcePath "img/master.png" )
    ]


{-| beiminSprites
-}
beiminSprites : List ( String, String )
beiminSprites =
    [ ( "bm/ground", getResourcePath "img/bmground.png" )
    , ( "bm/leaf", getResourcePath "img/bmleaf.png" )
    , ( "bm/lotus", getResourcePath "img/bmlotus.png" )
    , ( "bm/smallwave", getResourcePath "img/bmsmallwave.png" )
    ]


{-| donghaiSprites
-}
donghaiSprites : List ( String, String )
donghaiSprites =
    [ ( "dh/smallrock", getResourcePath "img/dhsmallrock.png" )
    , ( "dh/rock", getResourcePath "img/dhrock.png" )
    , ( "dh/bigrock", getResourcePath "img/dhbigrock.png" )
    ]


{-| jiangnanSprites
-}
jiangnanSprites : List ( String, String )
jiangnanSprites =
    [ ( "jn/roof", getResourcePath "img/jnroof.png" )
    , ( "jn/PieceOfRoof", getResourcePath "img/jnPieceOfRoof.png" )
    , ( "jn/leaf", getResourcePath "img/jnleaf.png" )
    , ( "jn/building", getResourcePath "img/jnbuilding.png" )
    ]


{-| longxiSprites
-}
longxiSprites : List ( String, String )
longxiSprites =
    [ ( "lx/rock", getResourcePath "img/lxrock.png" )
    , ( "lx/plane", getResourcePath "img/lxplane.png" )
    , ( "lx/PieceOfGround", getResourcePath "img/lxPieceOfGround.png" )
    , ( "lx/mountain", getResourcePath "img/lxmountain.png" )
    , ( "lx/ground", getResourcePath "img/lxground.png" )
    , ( "bamboo", getResourcePath "img/lxbamboo.png" )
    ]


{-| zhongyuanSprites
-}
zhongyuanSprites : List ( String, String )
zhongyuanSprites =
    [ ( "zy/stick", getResourcePath "img/zystick.png" )
    , ( "zy/platform", getResourcePath "img/zyplatform.png" )
    , ( "zy/building", getResourcePath "img/zybuilding.png" )
    ]


{-| otherSprites
-}
otherSprites : List ( String, String )
otherSprites =
    [ ( "ot/transfer", getResourcePath "img/transfer.png" )
    , ( "ot/block", getResourcePath "img/block.png" )
    , ( "ot/cave", getResourcePath "img/cave.png" )
    , ( "ot/scale", getResourcePath "img/scale.png" )
    , ( "ot/fireball1", getResourcePath "img/fire1.png" )
    , ( "ot/fireball2", getResourcePath "img/fire2.png" )
    , ( "scroll", getResourcePath "img/scroll.png" )
    , ( "ot/setting", getResourcePath "img/setting.png" )
    , ( "ot/status", getResourcePath "img/status.png" )
    , ( "ot/map", getResourcePath "img/map.png" )
    , ( "ot/vup", getResourcePath "img/volume-up.png" )
    , ( "ot/vdown", getResourcePath "img/volume-down.png" )
    , ( "ot/crystal", getResourcePath "img/crystal.png" )
    , ( "ot/crystaldead", getResourcePath "img/crystaldead.png" )
    , ( "ot/ball", getResourcePath "img/ball.png" )
    ]


backgroundSprites : List ( String, String )
backgroundSprites =
    [ ( "bg/zy", getResourcePath "img/ZhongYuan.jpg" )
    , ( "bg/lx", getResourcePath "img/LongXi.jpg" )
    , ( "bg/jn", getResourcePath "img/JiangNan.jpg" )
    , ( "bg/dh", getResourcePath "img/DongHai.jpg" )
    , ( "bg/bm", getResourcePath "img/BeiMing.jpg" )
    ]
