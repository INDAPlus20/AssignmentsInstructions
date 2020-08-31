{-| Author: Tomas Möre 2017
-}
{-# LANGUAGE RecordWildCards #-}
module Graphics.Shaders where

import qualified Graphics.Rendering.OpenGL as GL
import Data.StateVar
import Data.Monoid

import qualified Data.ByteString as B

{-| The program data hols all data necessary to "communicate" with the
  graphics card. The GL.Program is simply an id that enables
-}
data Program = Program
               { glProgram          :: GL.Program
               , colorUniform       :: GL.UniformLocation
               , positionUniform    :: GL.UniformLocation
               , cameraUniform      :: GL.UniformLocation
               , aspectRatioUniform :: GL.UniformLocation
               } deriving (Show, Eq)

{-| Some types for keeping track of datatypes to be sent to the graphics
  card
-}
type Color = GL.Vector3 Float
type Position = GL.Vector2 Float
type Camera = GL.Vector3 Float
type AspectRatio = Float

{-| Standard colors
-}
red :: Color
red = GL.Vector3 1 0 0
green :: Color
green = GL.Vector3 0 1 0
blue :: Color
blue = GL.Vector3 0 0 1

{-| Need to be called on before any other rendering of the program.
Binds shader program specific data to the right locations on the
graphics card.
-}
initDraw :: Program -> IO ()
initDraw Program{..} = do
  GL.currentProgram $= (Just glProgram)
  GL.vertexAttribArray (GL.AttribLocation 0) $= GL.Enabled
  GL.clearColor $= GL.Color4 0 0 0 0
  GL.clear [GL.ColorBuffer, GL.DepthBuffer]

{-|
Sets the camera position in the program
-}
setCamera :: Program -> Camera -> IO ()
setCamera Program{..} cam =
  GL.uniform cameraUniform $= cam

{-| Sets the aspect ratio in the program
-}
setAspectRatio :: Program -> AspectRatio -> IO ()
setAspectRatio Program{..} ar =
   GL.uniform aspectRatioUniform $= ar

{-| Loads the two fragment and vertex shaders and tries to construct a
program from them. If something fails on the way the result will be a
Left String where string is some kind of error message for debug
purposes.
-}
loadProgram :: FilePath -> FilePath -> IO (Either String Program)
loadProgram vertexFp fragmentFp = do
  eitherProgram <- loadShaderProgram vertexFp fragmentFp
  case eitherProgram of
    Right program -> do
      GL.currentProgram $= Just program
      GL.clearColor $= GL.Color4 0 0 0 0
      let getUniform = GL.uniformLocation program
      fmap Right $ Program <$> pure program
                           <*> getUniform "cubeColor"
                           <*> getUniform "cubePosition"
                           <*> getUniform "cameraPosition"
                           <*> getUniform "aspectRatio"
    Left e -> pure $ Left e



{-|   Loads the shader given a path to a fragmentshader and vertex shader.

-}
loadShaderProgram :: FilePath -> FilePath -> IO (Either String GL.Program)
loadShaderProgram vertexPath fragmentPath = do
  vertexShaderStr <- B.readFile vertexPath
  fragmentShaderStr  <- B.readFile fragmentPath

  vertexShader <- GL.createShader GL.VertexShader
  fragmentShader <- GL.createShader GL.FragmentShader

  GL.shaderSourceBS vertexShader $= vertexShaderStr
  GL.shaderSourceBS fragmentShader $= fragmentShaderStr

  GL.compileShader vertexShader
  GL.compileShader fragmentShader

  vertexCompilationOK <- GL.compileStatus vertexShader
  fragmentCompilationOK <- GL.compileStatus fragmentShader

  if not (vertexCompilationOK && vertexCompilationOK)
    then do vertexErrors <- if vertexCompilationOK
                            then pure ""
                            else do errorStr <- GL.shaderInfoLog vertexShader
                                    pure $ "Couldn't compile vertex shader: \n Errors: \n" <>
                                           errorStr
            fragmentErrors <- if fragmentCompilationOK
                              then pure ""
                              else do errorStr <- GL.shaderInfoLog fragmentShader
                                      pure $ ("Couldn't compile fragment shader: \n Errors: \n" <> errorStr)
            pure $ Left $ vertexErrors <> fragmentErrors
    else do  program <- GL.createProgram
             GL.attachShader program vertexShader
             GL.attachShader program fragmentShader
             GL.linkProgram program

             linkStatusOK <- GL.linkStatus program
             if linkStatusOK
               then return (Right program)
               else return $ Left "Failed to link program"
