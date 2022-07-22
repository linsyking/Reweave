module Scenes.Home.Common exposing (XModel)

{-| This is the doc for this module

@docs XModel

-}

import Scenes.Home.LayerBase exposing (CommonData)
import Scenes.Home.LayerSettings exposing (LayerCT)


{-| XModel
-}
type alias XModel =
    { commonData : CommonData
    , layers : List ( String, LayerCT )
    }
