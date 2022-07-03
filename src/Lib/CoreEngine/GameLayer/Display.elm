module Lib.CoreEngine.GameLayer.Display exposing (..)

import Array
import Array.Extra
import Base exposing (GlobalData)
import Canvas exposing (Renderable, group)
import Lib.CoreEngine.Base exposing (GameGlobalData)
import Lib.CoreEngine.GameComponent.Base exposing (GameComponent)
import Lib.CoreEngine.GameLayer.Common exposing (Model)
import Lib.CoreEngine.Physics.NaiveCollision exposing (judgeInCamera)


view : ( Model, Int ) -> GameGlobalData -> GlobalData -> Renderable
view ( model, t ) ggd gd =
    let
        allobjs =
            Array.push model.player model.actors
    in
    group []
        (Array.toList (Array.Extra.filterMap (\x -> renderSingleObject t x ggd gd) allobjs))


renderSingleObject : Int -> GameComponent -> GameGlobalData -> GlobalData -> Maybe Renderable
renderSingleObject t gc ggd gd =
    if judgeInCamera gc ggd then
        -- Should show
        Just (gc.view ( gc.data, t ) ggd gd)

    else
        Nothing
