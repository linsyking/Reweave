module Base exposing (Flags, GlobalData, Msg(..))

import Audio
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
    | SoundLoaded (Result Audio.LoadError Audio.Source)
    | PlaySoundGotTime Time.Posix
    | UnknownMsg


type alias GlobalData =
    { browserViewPort : ( Int, Int )
    , realWidth : Int
    , realHeight : Int
    , startLeft : Float
    , startTop : Float
    , audioVolume : Float
    }


type alias Flags =
    { windowWidth : Int
    , windowHeight : Int
    }



--- eg. Scene1 can export this type of message to other scenes
