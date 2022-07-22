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

@docs charaSprites

@docs beiminSprites

@docs donghaiSprites

@docs jiangnanSprites

@docs longxiSprites

@docs zhongyuanSprites

@docs otherSprites

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
    [ ( "background", getResourcePath "img/Background/DongHai.jpg" )
    , ( "lcloud", getResourcePath "img/cloud.png" )
    , ( "spikeL", getResourcePath "img/Spike/spikeL.png" )
    , ( "spikeR", getResourcePath "img/Spike/spikeR.png" )
    , ( "spikeT", getResourcePath "img/Spike/spikeT.png" )
    , ( "spikeB", getResourcePath "img/Spike/spikeB.png" )
    , ( "blueshadow", getResourcePath "img/ki.png" )
    , ( "skull", getResourcePath "img/Spike/skull.png" )
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
    [ ( "fish", getResourcePath "img/Monsters/fish.png" )
    , ( "turtle", getResourcePath "img/Monsters/turtle.png" )
    , ( "goomba", getResourcePath "img/Monsters/small.png" )
    , ( "goombadie", getResourcePath "img/Monsters/smalldie.png" )
    ]


{-| charaSprites
-}
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


{-| beiminSprites
-}
beiminSprites : List ( String, String )
beiminSprites =
    [ ( "bm/ground", getResourcePath "img/BeiMin/ground.png" )
    , ( "bm/leaf", getResourcePath "img/BeiMin/leaf.png" )
    , ( "bm/lotus", getResourcePath "img/BeiMin/lotus.png" )
    , ( "bm/smallwave", getResourcePath "img/BeiMin/smallwave.png" )
    ]


{-| donghaiSprites
-}
donghaiSprites : List ( String, String )
donghaiSprites =
    [ ( "dh/smallrock", getResourcePath "img/DongHai/smallrock.png" )
    , ( "dh/rock", getResourcePath "img/DongHai/rock.png" )
    , ( "dh/bigrock", getResourcePath "img/DongHai/bigrock.png" )
    ]


{-| jiangnanSprites
-}
jiangnanSprites : List ( String, String )
jiangnanSprites =
    [ ( "jn/roof", getResourcePath "img/JiangNan/roof.png" )
    , ( "jn/PieceOfRoof", getResourcePath "img/JiangNan/PieceOfRoof.png" )
    , ( "jn/leaf", getResourcePath "img/JiangNan/leaf.png" )
    , ( "jn/building", getResourcePath "img/JiangNan/building.png" )
    ]


{-| longxiSprites
-}
longxiSprites : List ( String, String )
longxiSprites =
    [ ( "lx/rock", getResourcePath "img/LongXi/rock.png" )
    , ( "lx/plane", getResourcePath "img/LongXi/plane.png" )
    , ( "lx/PieceOfGround", getResourcePath "img/LongXi/PieceOfGround.png" )
    , ( "lx/mountain", getResourcePath "img/LongXi/mountain.png" )
    , ( "lx/ground", getResourcePath "img/LongXi/ground.png" )
    , ( "bamboo", getResourcePath "img/LongXi/bamboo.png" )
    ]


{-| zhongyuanSprites
-}
zhongyuanSprites : List ( String, String )
zhongyuanSprites =
    [ ( "zy/stick", getResourcePath "img/ZhongYuan/stick.png" )
    , ( "zy/platform", getResourcePath "img/ZhongYuan/platform.png" )
    , ( "zy/building", getResourcePath "img/ZhongYuan/building.png" )
    ]


{-| otherSprites
-}
otherSprites : List ( String, String )
otherSprites =
    [ ( "ot/transfer", getResourcePath "img/Others/transfer.png" )
    , ( "ot/block", getResourcePath "img/Others/block.png" )
    , ( "ot/cave", getResourcePath "img/Others/cave.png" )
    , ( "ot/scale", getResourcePath "img/Others/scale.png" )
    , ( "ot/fireball1", getResourcePath "img/Others/fire1.png" )
    , ( "ot/fireball2", getResourcePath "img/Others/fire2.png" )
    , ( "scroll", getResourcePath "img/Others/scroll.png" )
    , ( "ot/setting", getResourcePath "img/Others/setting.png" )
    , ( "ot/status", getResourcePath "img/Others/status.png" )
    , ( "ot/map", getResourcePath "img/Others/map.png" )
    , ( "ot/vup", getResourcePath "img/Others/volume-up.png" )
    , ( "ot/vdown", getResourcePath "img/Others/volume-down.png" )
    , ( "ot/crystal", getResourcePath "img/Others/crystal.png" )
    , ( "ot/crystaldead", getResourcePath "img/Others/crystaldead.png" )
    , ( "ot/ball", getResourcePath "img/Others/ball.png" )
    ]


backgroundSprites : List ( String, String )
backgroundSprites =
    [ ( "bg/zy", getResourcePath "img/Background/ZhongYuan.jpg" )
    , ( "bg/lx", getResourcePath "img/Background/LongXi.jpg" )
    , ( "bg/jn", getResourcePath "img/Background/JiangNan.jpg" )
    , ( "bg/dh", getResourcePath "img/Background/DongHai.jpg" )
    , ( "bg/bm", getResourcePath "img/Background/BeiMing.jpg" )
    ]
