{-|
Author: Tomas Möre 2017
-}
{-# LANGUAGE RecordWildCards #-}
module Graphics.Cube(initRenderData, initDraw, draw, RenderData(..)) where

import qualified Graphics.Shaders as Shader

import qualified Graphics.Rendering.OpenGL as GL
import Data.StateVar

import qualified Data.Vector.Storable as S

import Foreign.Storable (sizeOf)
import Foreign.Ptr

{-| The data necesary to draw a cube. Contains the shader program
-}
data RenderData = RenderData
                { program :: Shader.Program
                , vao       :: GL.VertexArrayObject
                } deriving (Eq,Show)

{-| Initates the data for drawing to
-}
initDraw :: RenderData -> IO ()
initDraw RenderData{..} = do
  Shader.initDraw program
  GL.bindVertexArrayObject  $=! (Just vao)
  GL.vertexAttribArray (GL.AttribLocation 0) $= GL.Enabled

{-|
Draws a cube
-}
draw :: RenderData -> Shader.Color -> Shader.Position -> IO ()
draw RenderData{..} color pos = do
    GL.uniform (Shader.colorUniform program) $= color
    GL.uniform (Shader.positionUniform program) $= pos
    GL.drawElements GL.Triangles (fromIntegral (S.length indices)) GL.UnsignedShort nullPtr

{-|
Creates the renderdata for a cube.
-}
initRenderData :: Shader.Program -> IO RenderData
initRenderData glp@Shader.Program{..} = do
  vertexArrayObject <- GL.genObjectName
  GL.bindVertexArrayObject $=! Just vertexArrayObject

  vertexBufferObject <- GL.genObjectName
  GL.bindBuffer GL.ArrayBuffer $=! Just vertexBufferObject
  S.unsafeWith vertices
                    (\ptr ->
                        GL.bufferData GL.ArrayBuffer $=! (fromIntegral $ S.length vertices * sizeOf (S.head vertices)
                                                         , ptr
                                                         , GL.StaticDraw)
                    )
  GL.vertexAttribPointer (GL.AttribLocation 0) $=! (GL.ToFloat
                                                   , GL.VertexArrayDescriptor 3 GL.Float 0 nullPtr
                                                   )
  indexBufferObject <- GL.genObjectName
  GL.bindBuffer GL.ElementArrayBuffer $=! Just indexBufferObject

  S.unsafeWith indices
                    (\ptr ->
                        GL.bufferData GL.ElementArrayBuffer $=! ( fromIntegral $ S.length indices * sizeOf (S.head vertices)
                                                                , ptr
                                                                , GL.StaticDraw)
                    )
  pure $ RenderData glp vertexArrayObject



-- | Data for the cube vertices every line is one point
vertices :: S.Vector GL.GLfloat
vertices = S.fromList [
  -1, 1, 1,
   1, 1, 1,
   1, 1,-1,
  -1, 1,-1,
  -1,-1, 1,
   1,-1, 1,
   1,-1,-1,
  -1,-1,-1
  ]
-- | indices for a cube. Every line is a triangle
indices :: S.Vector GL.GLushort
indices = S.fromList [
  7, 3, 2,
  7, 2, 6,
  6, 2, 1,
  6, 1, 5,
  5, 1, 0,
  5, 0, 4,
  4, 0, 3,
  4, 3, 7,
  3, 0, 1,
  3, 1, 2,
  7, 5, 4,
  7, 6, 5
  ]
