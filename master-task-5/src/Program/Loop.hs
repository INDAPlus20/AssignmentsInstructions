{-|
Author: Tomas Möre 2017
-}
{-# LANGUAGE RecordWildCards #-}
module Program.Loop (HasDrawData(..), runProgram)where

import Input.Events
import qualified Graphics.Cube as Cube
import qualified Graphics.Shaders as Shader

import qualified Graphics.Rendering.OpenGL as GL
import qualified Graphics.UI.GLFW as GLFW

import Data.StateVar hiding (get)

import Control.Monad


{-| Since we want to be able to have any arbitary datastructure as the
  state of the program there must be some way to retrieve the data
  necessary to draw the objects to the screen. HasDrawData exist for
  this reason. Just create an instance HasDrawData for you datatype.
-}
class HasDrawData a where
  cubes :: a -> [(Float,Float)]
  cameraPosition :: a -> (Float,Float,Float)

{-|
Runprogram in the entry point for the main loop it makes sure that things are initated correctly then
-}
runProgram :: (HasDrawData s) => GLFW.Window -> Cube.RenderData -> s -> (Event -> s -> s) -> IO ()
runProgram window rd@Cube.RenderData{..} initialState action = do
  Shader.initDraw program
  Shader.setCamera program $ GL.Vector3 0 0 0
  Shader.setAspectRatio program 1
  GLFW.setFramebufferSizeCallback window $ Just
    (\ _ w h -> do
        GL.viewport $= (GL.Position 0 0, GL.Size (fromIntegral w) (fromIntegral h))
        Shader.setAspectRatio program (fromIntegral w / fromIntegral h)
    )
  eventChannel <- createEventListners window
  mainLoop rd window eventChannel initialState action

{-|
The actual mainloop, update the state, draws the state, polls events and loops.
-}
mainLoop :: (HasDrawData s) => Cube.RenderData -> GLFW.Window -> EventChan -> s -> (Event -> s -> s) -> IO ()
mainLoop rd@Cube.RenderData{..} window  chan oldState action = do
   newState <- foldrEvents chan action oldState
   Shader.initDraw program
   Cube.initDraw rd
   let (camX, camY, camZ) = cameraPosition newState
   Shader.setCamera program (GL.Vector3 camX camY camZ)
   mapM_ (\ (px,py) ->
            Cube.draw rd Shader.red (GL.Vector2 px py)
         )
         (cubes newState)

   GLFW.swapBuffers window
   GLFW.pollEvents
   shouldClose <- GLFW.windowShouldClose window
   unless shouldClose (mainLoop rd window chan newState action)
