module Lib.Resources.Base exposing (..)

import Base exposing (Msg(..))
import Canvas exposing (text)
import Canvas.Texture as Texture exposing (Texture)
import Dict exposing (Dict)


getResourcePath : String -> String
getResourcePath x =
    "assets/" ++ x


getTexture : List (Texture.Source Msg)
getTexture =
    List.map (\( x, y ) -> Texture.loadFromImageUrl y (TextureLoaded x)) allTexture


saveSprite : Dict String Texture -> String -> Texture -> Dict String Texture
saveSprite dst name text =
    Dict.insert name text dst


igetSprite : String -> Dict String Texture -> Maybe Texture
igetSprite name dst =
    Dict.get name dst


allTexture : List ( String, String )
allTexture =
    [ ( "background", getResourcePath "img/bg.jpg" )
    , ( "rcloud", getResourcePath "img/rcloud.png" )
    , ( "lcloud", getResourcePath "img/lcloud.png" )
    , ( "spikeL", getResourcePath "img/Spike/spikeL.png" )
    , ( "spikeR", getResourcePath "img/Spike/spikeR.png" )
    , ( "spikeT", getResourcePath "img/Spike/spikeT.png" )
    , ( "spikeB", getResourcePath "img/Spike/spikeB.png" )
    , ( "dialogue", getResourcePath "img/dialogue.png" )
    , ( "downbutton", getResourcePath "img/down.png" )
    , ( "bullet", getResourcePath "img/bullet.png" )
    , ( "fish", getResourcePath "img/Monsters/fish.png" )
    , ( "whiteshadow", getResourcePath "img/white-shadow.png" )
    , ( "blueshadow", getResourcePath "img/ki.png" )
    , ( "goomba", getResourcePath "img/Monsters/small.png" )
    , ( "goombadie", getResourcePath "img/Monsters/smalldie.png" )
    ]
        ++ charaSprites
        ++ beiminSprites
        ++ donghaiSprites
        ++ jiangnanSprites
        ++ longxiSprites
        ++ zhongyuanSprites
        ++ otherSprites


charaSprites : List ( String, String )
charaSprites =
    [ ( "p_jump", getResourcePath "img/Characters/p_jump.png" )
    , ( "p_stand", getResourcePath "img/Characters/p_stand.png" )
    , ( "p_fall", getResourcePath "img/Characters/p_fall.png" )
    , ( "p_m1", getResourcePath "img/Characters/p_m1.png" )
    , ( "p_m2", getResourcePath "img/Characters/p_m2.png" )
    , ( "p_m3", getResourcePath "img/Characters/p_m3.png" )
    , ( "p_m4", getResourcePath "img/Characters/p_m4.png" )
    , ( "p_m5", getResourcePath "img/Characters/p_m5.png" )
    , ( "p_m6", getResourcePath "img/Characters/p_m6.png" )
    , ( "p_profile", getResourcePath "img/Characters/profile.png" )
    , ( "master", getResourcePath "img/Characters/master.png" )
    ]


beiminSprites : List ( String, String )
beiminSprites =
    [ ( "bm/ground", getResourcePath "img/BeiMin/ground.png" )
    , ( "bm/leaf", getResourcePath "img/BeiMin/leaf.png" )
    , ( "bm/lotus", getResourcePath "img/BeiMin/lotus.png" )
    ]


donghaiSprites : List ( String, String )
donghaiSprites =
    [ ( "dh/smallrock", getResourcePath "img/DongHai/smallrock.png" )
    , ( "dh/rock", getResourcePath "img/DongHai/rock.png" )
    , ( "dh/bigrock", getResourcePath "img/DongHai/bigrock.png" )
    ]


jiangnanSprites : List ( String, String )
jiangnanSprites =
    [ ( "jn/roof", getResourcePath "img/JiangNan/roof.png" )
    , ( "jn/PieceOfRoof", getResourcePath "img/JiangNan/PieceOfRoof.png" )
    , ( "jn/leaf", getResourcePath "img/JiangNan/leaf.png" )
    , ( "jn/building", getResourcePath "img/JiangNan/building.png" )
    ]


longxiSprites : List ( String, String )
longxiSprites =
    [ ( "lx/rock", getResourcePath "img/LongXi/rock.png" )
    , ( "lx/plane", getResourcePath "img/LongXi/plane.png" )
    , ( "lx/PieceOfGround", getResourcePath "img/LongXi/PieceOfGround.png" )
    , ( "lx/mountain", getResourcePath "img/LongXi/mountain.png" )
    , ( "lx/ground", getResourcePath "img/LongXi/ground.png" )
    ]


zhongyuanSprites : List ( String, String )
zhongyuanSprites =
    [ ( "zy/stick", getResourcePath "img/ZhongYuan/stick.png" )
    , ( "zy/platform", getResourcePath "img/ZhongYuan/platform.png" )
    , ( "zy/buiding", getResourcePath "img/ZhongYuan/buiding.png" )
    ]


otherSprites : List ( String, String )
otherSprites =
    [ ( "ot/transfer", getResourcePath "img/Others/transfer.png" )
    , ( "ot/block", getResourcePath "img/Others/block.png" )
    , ( "ot/cave", getResourcePath "img/Others/cave.png" )
    , ( "ot/scale", getResourcePath "img/Others/scale.png" )
    ]
