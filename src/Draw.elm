module Draw exposing (..)

import Common exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Math.Matrix4 as Mat4 exposing (Mat4)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)



--- Draw Objects on the screen
--- Test: Only draw the player


drawG : Model -> Html Msg
drawG model =
    let
        ( lt, rb ) =
            getActorPosition (getPlayer model)

        ( x1, y1 ) =
            coordinateTransform ( lt.x, lt.y )

        pwidth =
            widthTransform (rb.x - lt.x)

        pheight =
            heightTransform (rb.y - lt.y)
    in
    -- Debug.log ("!!" ++ Debug.toString x1 ++ "," ++ Debug.toString y1 ++ "!!")
    -- Debug.log ("!!" ++ Debug.toString lt ++ "," ++ Debug.toString rb ++ "!!")
    -- dbge [ pwidth, pheight, x1, y1, toFloat lt.y ]
    WebGL.toHtml
        [ width screen_width
        , height screen_height
        , style "display" "block"
        , style "background-color" "#dcdcf3"
        ]
        [ WebGL.entity
            vertexShader
            fragmentShader
            (rectangle x1 y1 pwidth pheight)
            { perspective = perspective }
        ]


perspective : Mat4
perspective =
    Mat4.identity



-- Mat4.mul
--     (Mat4.makePerspective 45 1 0.01 100)
--     (Mat4.makeLookAt (vec3 (4 * cos 1) 0 (4 * sin 1)) (vec3 0 0 0) (vec3 0 1 0))
-- Mesh


type alias Vertex =
    { position : Vec3
    , color : Vec3
    }



-- mesh : Float -> Mesh Vertex
-- mesh x =
--     rectangle 0 (x / 1000) 0.5 0.5
-- mesh2 : Float -> Mesh Vertex
-- mesh2 x =
--     rectangle (x / 1000) 0 0.5 0.5


rectangle : Float -> Float -> Float -> Float -> Mesh Vertex
rectangle x y w h =
    WebGL.triangles
        [ ( Vertex (vec3 x y 0) (vec3 1 0 0)
          , Vertex (vec3 (x + w) y 0) (vec3 1 0 0)
          , Vertex (vec3 (x + w) (y - h) 0) (vec3 1 0 0)
          )
        , ( Vertex (vec3 x y 0) (vec3 1 0 0)
          , Vertex (vec3 (x + w) (y - h) 0) (vec3 1 0 0)
          , Vertex (vec3 x (y - h) 0) (vec3 1 0 0)
          )
        ]



-- Shaders


type alias Uniforms =
    { perspective : Mat4 }


vertexShader : Shader Vertex Uniforms { vcolor : Vec3 }
vertexShader =
    [glsl|

        attribute vec3 position;
        attribute vec3 color;
        uniform mat4 perspective;
        varying vec3 vcolor;

        void main () {
            gl_Position = perspective * vec4(position, 1.0);
            vcolor = color;
        }

    |]


fragmentShader : Shader {} Uniforms { vcolor : Vec3 }
fragmentShader =
    [glsl|

        precision mediump float;
        varying vec3 vcolor;

        void main () {
            gl_FragColor = vec4(vcolor, 1.0);
        }

    |]
