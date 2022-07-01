# Introduction

`CoreEngine` is a submodule for our game. Its function is to construct the game level.

The engine mainly includes the following things:

- Physics engine (including collison)
- Camera
- Layers for rendering

This engine will output a Scene which needs a init parameter.

We use `GameComponent` instead of `Component` to control the game objects (only the interactive objects, not including things like the Energy Bar)

The layers will be rendered by the order:

1. FrontgroundLayer: Including HealthBar and Menus and so on
2. GameLayer: Including all game objects
3. BackgroundLayer: Inclusing backgrounds

## GameLayer

This layer calculates the collision between object and solid/object and object, and sent the collision result to the objects themselves. Objects will deal with those collision results.

In one game component, you have access to the `GameGloablData` data, which includes solid map and camera position, which is useful.
