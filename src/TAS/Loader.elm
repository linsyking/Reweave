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
loadTAS : List ( Int, List Input ) -> List ( Int, List Msg )
loadTAS xs =
    List.map
        (\( a, b ) ->
            ( a
            , List.map
                (\c ->
                    case c of
                        Down TAS.A ->
                            KeyDown 65

                        Down TAS.C ->
                            KeyDown 67

                        Down TAS.D ->
                            KeyDown 68

                        Down TAS.W ->
                            KeyDown 87

                        Down TAS.E ->
                            KeyDown 69

                        Up TAS.A ->
                            KeyUp 65

                        Up TAS.C ->
                            KeyUp 67

                        Up TAS.D ->
                            KeyUp 68

                        Up TAS.W ->
                            KeyUp 87

                        Up TAS.E ->
                            KeyUp 69

                        MouseLeft pos ->
                            MouseDownInt 0 pos

                        MouseRright pos ->
                            MouseDownInt 2 pos
                )
                b
            )
        )
        xs
