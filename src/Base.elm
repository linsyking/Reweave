module Base exposing (Flags, GlobalData, Msg(..))

import Audio
import Canvas.Texture exposing (Texture)
import Dict exposing (Dict)
import Lib.Audio.Base exposing (AudioOption)
import Time



--- WARNING: This file should have no dependencies
--- Otherwise it will cause import-cycles
--- I storage TMsg here that every scene can use it to transmit data, however, those data can only be Int, Float, Strong, etc.
--- This message is the GLOBAL scope message. This message limits what messsages you can get inside a scene.


type Msg
    = Tick Time.Posix
    | KeyDown Int
    | KeyUp Int
    | StringMessage String
    | NewWindowSize ( Int, Int )
    | SoundLoaded String AudioOption (Result Audio.LoadError Audio.Source)
    | PlaySoundGotTime String AudioOption Audio.Source Time.Posix
    | TextureLoaded String (Maybe Texture)
    | MouseDown ( Float, Float )
    | UnknownMsg


type alias GlobalData =
    { browserViewPort : ( Int, Int )
    , realWidth : Int
    , realHeight : Int
    , startLeft : Float
    , startTop : Float
    , audioVolume : Float
    , sprites : Dict String Texture
    }


type alias Flags =
    { windowWidth : Int
    , windowHeight : Int
    }



--- eg. Scene1 can export this type of message to other scenes
