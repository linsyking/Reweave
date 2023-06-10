module TAS.Loader exposing (loadTAS)

{-|


# TAS Loader

Load TAS to Msgs

@docs loadTAS

-}

import Base exposing (Msg(..))
import TAS.TAS as TAS exposing (Input(..))


{-| load TAS
-}
loadTAS : List ( Int, Input ) -> List ( Int, Msg )
loadTAS xs =
    List.map
        (\( a, b ) ->
            ( a
            , case b of
                Down TAS.A ->
                    KeyDown 65

                Down TAS.C ->
                    KeyDown 67

                Down TAS.D ->
                    KeyDown 68

                Up TAS.A ->
                    KeyDown 65

                Up TAS.C ->
                    KeyDown 67

                Up TAS.D ->
                    KeyDown 68

                MouseLeft pos ->
                    MouseDownInt 0 pos

                MouseRright pos ->
                    MouseDownInt 1 pos
            )
        )
        xs
