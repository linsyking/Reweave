module Scenes.Scene1.Common exposing (XModel)

{-| This is the doc for this module

@docs XModel

-}

import Scenes.Scene1.LayerBase exposing (CommonData)
import Scenes.Scene1.LayerSettings exposing (LayerCT)


{-| XModel
-}
type alias XModel =
    { commonData : CommonData
    , layers : List ( String, LayerCT )
    }
