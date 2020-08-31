{-|
Author: Tomas Möre 2017
This is a small program that handles a simple todolist.
-}
module Main where

import System.IO hiding (readFile)
import System.Directory(doesFileExist)
import System.Environment
import Text.Read (readMaybe)
import Data.Maybe
import Data.List (intercalate)

import qualified Data.Text as T
import qualified Data.Text.IO as T

-- | Simple time format so we don't have to dabble with other type mysteries
data Time = Time
            { year   :: Int
            , month  :: Int
            , day    :: Int
            , hour   :: Int
            , minute :: Int
            } deriving (Show, Read, Eq,Ord)

type Title = String

{-|
the data type for the todolist. It really is a list of events but should
be sorted according to the event order
-}
type TodoList = [Event]

{-|
The event data is simply what we hold in memory.
-}
data Event = Event Title Time
  deriving (Show, Read, Eq)

{-| Defining the order of the event to be acording the the order of the
time.
-}
instance Ord Event where
  compare (Event _ t1) (Event _ t2) = compare t1 t2

{-| The UserInput datatype defines a set of "messages" that the user
  should be able to send to the program. All must not be defined when
  you run it but this is one way to handle separation of IO and the
  rest of the program. Also enforcing this rune gives us some security
  in that we know that the user has entered a valid input.
-}
data UserInput = AddEvent Title Time
               | DeleteEventsTo Time
               | ListEvents
               deriving (Show, Read, Eq)

{-| The result of an "execution" tells the main program what
the it should do after the execution is done.
-}
data ExecutionResult = ExecutionError String
                     | ExecutionOK
                     | ExecutionModified TodoList
                     | ExecutionPrompt String


maybeGet :: [a] -> Int -> Maybe a
maybeGet [] _ = Nothing
maybeGet (x:xs) 0 = Just x
maybeGet (x:xs) n = maybeGet xs (n - 1)
{-| Small utility function for converting maybes to ethers
-}
maybeToEither :: a -> Maybe b -> Either a b
maybeToEither whenNothing = maybe (Left whenNothing) Right


{-|
Tries to parse a string into our special time format.
The input should be on the format YYYY MM DD HH MM.
if the hour or minute is missing it will replace it with 0
If year month or day is missing it will give an error back
-}
stringToTime :: String -> Either String Time
stringToTime str = do
  year  <- maybeToEither "Missing year" $ numAt 0
  month <- maybeToEither "Missing month" $ numAt 1
  day   <- maybeToEither "Missing day" $ numAt 2
  let hour = fromMaybe 0 (numAt 3 >>= inRange 0 23)
      minute = fromMaybe 0 (numAt 4 >>= inRange 0 59)
  return $ Time year month day hour minute
    where
      numAt n = do
        element <- maybeGet (words str) n
        readMaybe element
      inRange min max n = if min <= n && n <= max
                          then Just n
                          else Nothing

{-|
Read command takes
-}
readCommand :: [String] -> Either String UserInput
readCommand [] = Left "Missing command"
readCommand (commandStr:rest) =
  case commandStr of
    "add" -> do
      title <- maybeToEither "Missing title"  $ maybeGet rest 0
      dateStr <- maybeToEither "Missing date field" $ maybeGet rest 1
      date <- stringToTime dateStr
      return $ AddEvent title date
    "list" -> pure $ ListEvents
    invalidCommandStr -> Left $ "Invalid command" ++ invalidCommandStr

{-|
Run command evaluates an user input
-}
runCommand :: UserInput -> TodoList -> ExecutionResult
runCommand (AddEvent title date) todoList = do
  if newEvent `elem` todoList
    then ExecutionError "Event already exists"
    else ExecutionModified $ insertEvent (Event title date) todoList
  where
    newEvent = Event title date
    insertEvent e [] = [e]
    insertEvent e (x:xs) =
      if x <= e
      then e:x:xs
      else x : insertEvent e xs

runCommand ListEvents todoList =
  ExecutionPrompt $ intercalate "\n" $ map show todoList
runCommand unhandledEvent _ =
  ExecutionError $ "Event not implemented: " ++ show unhandledEvent

{-|

-}
main :: IO ()
main = do
  input <- getArgs
  fileExists <- doesFileExist todoListFilePath
  todoList <- if fileExists
              then (readTodoFile . T.unpack ) <$> T.readFile todoListFilePath
              else pure []
  case readCommand input of
    Left error ->
      putStrLn $ "Invalid input data: " ++ error
    Right command ->
      case runCommand command todoList of
        ExecutionModified new ->
          writeFile todoListFilePath $ show new
        ExecutionError error ->
          putStrLn $ "Error while performing command: " ++ error
        ExecutionPrompt msg ->
          putStrLn $ msg
        ExecutionOK ->
          pure ()

  where
    todoListFilePath = "todo-lista"
    readTodoFile content =
      if null content
        then []
        else read content
