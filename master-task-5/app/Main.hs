{-# LANGUAGE RecordWildCards  #-}
module Main where
{-|
Author: Tomas Möre
-}
import Program.Loop
import qualified Graphics.Cube as Cube
import qualified Graphics.Init as Init
import qualified Graphics.Shaders as Shaders

import qualified Graphics.UI.GLFW as GLFW
import Control.Monad.Trans.Except
import Control.Monad.IO.Class

import Control.Monad

import System.Directory

import Data.Set (Set)
import qualified Data.Set as Set

import qualified Data.Map as Map
import Input.Events

vertexShader = "shaders/cube.vert"
fragmentShader =  "shaders/cube.frag"

type Cell = (Float,Float)
type Camera = (Float,Float,Float)

-- | Example state of the program. A list may not be the best choce.
-- You can roll with it or chose other datastructures.
data State = State
             { cells :: [Cell]
             , camera :: Camera
             }

instance HasDrawData State where
  cubes = cells
  cameraPosition = camera

defaultState = State [] (0, 0, 4)

update :: Event -> State -> State

{-| The main simply initiates the rendering and starts the gameloop with
the an update function for your specific games logic.
Remember that this basicly just can do a 2D grid of cubes.
-}
main :: IO ()
main = do
  renderDataEither <- loadProgram
  case renderDataEither  of
    Right (window, renderData) -> do
      runProgram window
                 renderData
                 defaultState
                 update
    Left e -> putStrLn e

{-| Some bootstap codeupdateGameOfLife
-}
loadProgram :: IO (Either String (GLFW.Window, Cube.RenderData))
loadProgram = runExceptT $ do
  window <- ExceptT $ Init.makeBasicWindow "Hello world"
  liftIO $ GLFW.makeContextCurrent (Just window)
  vertexExists <- liftIO $ doesFileExist vertexShader
  unless vertexExists $ throwE ("Vertex shader file doesn't exist: " ++ vertexShader)
  fragmentExists <- liftIO $ doesFileExist fragmentShader
  unless fragmentExists $  throwE ("fragment shader file doesn't exist: " ++ fragmentShader)
  baseProgram <- ExceptT $ Shaders.loadProgram vertexShader fragmentShader
  renderData <- liftIO $ Cube.initRenderData baseProgram
  pure (window, renderData)
