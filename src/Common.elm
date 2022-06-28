module Common exposing (..)

import Array
import Array2D
import Html exposing (b)
import Math.Vector2 exposing (Vec2, vec2)
import Time



--- Constants


screen_width : Int
screen_width =
    1024


screen_height : Int
screen_height =
    576


half_screen_width : Float
half_screen_width =
    toFloat screen_width / 2


half_screen_height : Float
half_screen_height =
    toFloat screen_height / 2


half_screen_height_mixed : Float
half_screen_height_mixed =
    toFloat (screen_height - 1) / 2


half_screen_width_mixed : Float
half_screen_width_mixed =
    toFloat (screen_width - 1) / 2



--- Constants


type alias Position =
    { x : Int
    , y : Int
    }


type KeyType
    = Left
    | Right
    | Up
    | Down
    | Space
    | UnKnown


type alias BoundKey =
    { left : Int
    , right : Int
    , up : Int
    , down : Int
    , space : Int
    }



--- 0: Not Pressed
--- 1: Is Pressing
--- 2: Released


changebk : KeyType -> Int -> BoundKey -> BoundKey
changebk key status bk =
    case key of
        Left ->
            { bk | left = status }

        Right ->
            { bk | right = status }

        Up ->
            { bk | up = status }

        Down ->
            { bk | down = status }

        Space ->
            { bk | space = status }

        UnKnown ->
            bk


afterMove : Model -> Model
afterMove model =
    --- Copy current keys to backup
    { model | lastOriginKeys = model.originKeys }


getPlayer : Model -> GActor
getPlayer model =
    case Array.get 0 model.actors of
        Just k ->
            k

        Nothing ->
            emptyActor


setPlayer : GActor -> Model -> Model
setPlayer actor model =
    { model | actors = Array.set 0 actor model.actors }


emptyActor : GActor
emptyActor =
    { name = ""
    , position = Position 0 0 -- Left Top coordinate
    , velocity = vec2 0 0
    , acceleration = vec2 0 0
    , boxes = Array.empty
    , show = Hidden
    }


coordinateTransform : ( Int, Int ) -> ( Float, Float )
coordinateTransform ( ix, iy ) =
    let
        x =
            toFloat ix

        y =
            toFloat iy
    in
    ( x / half_screen_width_mixed - 1, 1 - y / half_screen_height_mixed )


widthTransform : Int -> Float
widthTransform x =
    toFloat x / half_screen_width


heightTransform : Int -> Float
heightTransform y =
    toFloat y / half_screen_height


type SpaceLog
    = PressTime Int
    | Nope


type GObject
    = Actor GActor
    | Solid GSolid


type CameraShow
    = Display
    | Hidden


type alias GActor =
    { name : String
    , position : Position -- Left Top coordinate
    , velocity : Vec2
    , acceleration : Vec2
    , boxes : Array.Array Box
    , show : CameraShow
    }


getCollisionBox : GActor -> Box
getCollisionBox actor =
    case Array.get 0 actor.boxes of
        Just a ->
            a

        Nothing ->
            emptyBox


genSplits : Int -> Int -> Int -> Array.Array Int
genSplits a b s =
    if a >= b then
        Array.empty

    else
        let
            fgs =
                (b - a) // s
        in
        if modBy s (b - a) == 0 then
            Array.map (\x -> x * s + a) (Array.fromList (List.range 0 fgs))

        else
            Array.push b (Array.map (\x -> x * s + a) (Array.fromList (List.range 0 fgs)))


testMaybe : Maybe a -> Bool
testMaybe x =
    case x of
        Just _ ->
            True

        Nothing ->
            False


type BoxType
    = CollisionBox
    | Rebound


type alias Box =
    { relativePosition : Position
    , width : Int
    , height : Int
    , boxtype : BoxType
    }


emptyBox : Box
emptyBox =
    { relativePosition = Position 0 0
    , width = 0
    , height = 0
    , boxtype = CollisionBox
    }


type alias GSolid =
    { position : Position
    , content : Int
    }


type alias Model =
    { currentKeys : BoundKey
    , originKeys : BoundKey
    , keyPressed : SpaceLog
    , actors : Array.Array GActor
    , solidmap : Array2D.Array2D Int
    , currentTime : Int
    , jStartTime : Int
    , cameraPosition : Position
    , mapSize : ( Int, Int )
    , playerStates : PlayerStates
    , lastOriginKeys : BoundKey
    }


getMapSize : Model -> ( Int, Int )
getMapSize model =
    model.mapSize


getActorPosition : GActor -> ( Position, Position )
getActorPosition actor =
    let
        cb =
            getCollisionBox actor

        x1 =
            actor.position.x

        y1 =
            actor.position.y

        x2 =
            x1 + cb.relativePosition.x + cb.width - 1

        y2 =
            y1 + cb.relativePosition.y + cb.height - 1
    in
    ( Position x1 y1, Position x2 y2 )


sds : Array2D.Array2D number
sds =
    Array2D.repeat 128 72 0


ps : Array2D.Array2D number
ps =
    Array2D.appendColumn Array.empty 1 (Array2D.appendColumn Array.empty 1 sds)


velToDis : Float -> Float
velToDis x =
    x / 15


tupToPos : ( Int, Int ) -> Position
tupToPos ( x, y ) =
    Position x y


initModel : Model
initModel =
    { currentKeys = BoundKey 0 0 0 0 0
    , keyPressed = Nope
    , actors = Array.fromList [ gPlayer ]
    , solidmap = ps
    , currentTime = 0
    , jStartTime = 0
    , originKeys = BoundKey 0 0 0 0 0
    , cameraPosition = Position 0 0
    , mapSize = ( 128, 74 )
    , playerStates = PlayerStates []
    , lastOriginKeys = BoundKey 0 0 0 0 0
    }


gPlayer : GActor
gPlayer =
    { name = "main"
    , position = Position 100 (screen_height - 70)
    , velocity = vec2 0 0
    , acceleration = vec2 0 -10
    , boxes =
        Array.fromList
            [ { relativePosition = Position 0 0
              , width = 40
              , height = 70
              , boxtype = CollisionBox
              }
            ]
    , show = Display
    }



-- Player is the first actor


type Msg
    = Tick Time.Posix
    | KeyDown KeyType
    | KeyUp KeyType


keyDownConverter : Int -> Msg
keyDownConverter keycode =
    case keycode of
        87 ->
            KeyDown Up

        83 ->
            KeyDown Down

        65 ->
            KeyDown Left

        68 ->
            KeyDown Right

        32 ->
            KeyDown Space

        _ ->
            KeyDown UnKnown


keyUpConverter : Int -> Msg
keyUpConverter keycode =
    case keycode of
        87 ->
            KeyUp Up

        83 ->
            KeyUp Down

        65 ->
            KeyUp Left

        68 ->
            KeyUp Right

        32 ->
            KeyUp Space

        _ ->
            KeyUp UnKnown


dbge : List a -> b -> b
dbge dbgs x =
    Debug.log (Debug.toString dbgs) x


rfint : Int -> Int
rfint x =
    floor (toFloat x / 8)


type alias State =
    { key : String
    , starttime : Int
    , onEnter : Model -> Model
    , doing : Model -> Model
    , onExit : Model -> Model
    , ifExit : Model -> Bool
    }


type PlayerStates
    = PlayerStates (List State)
