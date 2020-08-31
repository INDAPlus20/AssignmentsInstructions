{-|
Author: Tomas Möre 2017
-}
module Input.Events where

import qualified Graphics.UI.GLFW as GLFW
import Control.Concurrent.STM.TChan

import Control.Monad.STM

{-| The event is a nicer version of the events that you can get from the
GLFW library. This exist mainly as a way to
-}
data Event = Quit
           | LeftArrow
           | RightArrow
           | UpArrow
           | DownArrow
           | Space
           | Enter
           | CharPress Char
           deriving (Show, Eq, Read)

{-| The channel type through which asyncrounous events are passen indo.
Sho
-}
type EventChan = TChan Event

{-| Folds through all events available in a channel until there's
  nothing left.
-}
foldrEvents :: EventChan -> (Event -> a -> a) -> a -> IO a
foldrEvents chan f prevState = do
  maybeEvent <- atomically $ tryReadTChan chan
  case maybeEvent of
    Just e -> foldrEvents  chan f (f e prevState)
    Nothing -> pure $ prevState


{-| Since handling events from the OS is a bit tedious

-}
createEventListners :: GLFW.Window -> IO (TChan Event)
createEventListners window = do
  chan <- newTChanIO
  GLFW.setCharCallback window (Just (charCallback chan))
  GLFW.setKeyCallback window (Just (keyCallback chan))
  pure chan


{-| The callback function used to handle key events. It makes an 'Event'
out of some of the input. Sends the events into the provided TChan
-}
keyCallback :: EventChan ->
               GLFW.Window ->
               GLFW.Key ->
               Int ->
               GLFW.KeyState ->
               GLFW.ModifierKeys ->
               IO ()
keyCallback chan _ key _ keyState _ =
  if GLFW.KeyState'Pressed == keyState || keyState == GLFW.KeyState'Repeating
  then case eventKey of
         Just e -> atomically $ writeTChan chan e
         Nothing -> pure ()
  else pure ()
  where
    eventKey =
      case key of
        GLFW.Key'Space -> Just Space
        GLFW.Key'Enter -> Just Enter
        GLFW.Key'Up    -> Just UpArrow
        GLFW.Key'Down  -> Just DownArrow
        GLFW.Key'Right -> Just RightArrow
        GLFW.Key'Left  -> Just LeftArrow
        _ -> Nothing

keyCallback _ _ _ _ _ _ = pure ()

{-|
For prossesing character press callbacks.
-}
charCallback :: EventChan -> GLFW.Window -> Char -> IO ()
charCallback chan window char =
  atomically  $ writeTChan chan $ CharPress char
