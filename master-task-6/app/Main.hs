-- | Author: Tomas Möre 2019
-- Slightly modified version of
module Main where

import Control.Monad.Trans
import System.Console.Repline
import System.Exit

import System.Process (callCommand)
import Data.List (isPrefixOf)

import BoolCalc

type Repl a = HaskelineT IO a

-- Evaluation : handle each line user inputs
cmd :: String -> Repl ()
cmd = liftIO . putStrLn . interpret

-- Tab Completion: return a completion for partial words entered
completer :: Monad m => WordCompleter m
completer n = do
  let names = ["kirk", "spock", "mccoy"]
  return $ filter (isPrefixOf n) names

-- Commands
help :: [String] -> Repl ()
help args = liftIO $ print $ "Help: " ++ show args

quit _ = liftIO $ do
  putStrLn "Bye bye!"
  exitSuccess

options :: [(String, [String] -> Repl ())]
options = [
    ("help", help)  -- :help
  , ("q", quit)
  , ("quit", quit)
  ]

ini :: Repl ()
ini = liftIO $ putStrLn "Welcome!"

repl :: IO ()
repl = evalRepl (pure ">>> ") cmd options (Just ':') (Word0 completer) ini

main :: IO ()
main = repl
