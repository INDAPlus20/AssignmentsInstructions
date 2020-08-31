-- | Author: Tomas Möre 2019
module BoolCalc where

import Text.Parsec
import qualified Data.Char as Char

data AST = Literal Bool
         | And AST AST
         | Or AST AST
         | Not AST
         deriving (Show, Read, Eq)

-- | Interprets an AST and gives us the evaluation result
eval :: AST -> Bool
eval (Literal b) = b
eval (And l r)   = eval l && eval r
eval (Or l r)    = eval l || eval r
eval (Not b)     = not (eval b)


-- | Evaluates a string with written in our boolean language.
-- If the string is correct then the
interpret :: String -> String
interpret str =
  case eval <$> parseAst (map Char.toLower str) of
    Left err -> "Error when parsing: " <> show err
    Right True -> "true"
    Right False -> "false"

-- | Parses a string. Returhing either an error or the abstract sytax tree of
-- the bool language
parseAst :: String -> Either String AST
parseAst s = case parse ast "Interpreter" s of
             Left err -> Left $ show err
             Right a -> Right a

-- | Short hand type for the parser we care about
type Parser = Parsec String ()

-- | Parser for the top level of the AST
ast :: Parser AST
ast = do
  spaces
  choice [ try notExpr
         , try boolExpr
         , try andExpr
         , orExpr
         ]

-- | Parse an expression:
--- `not <AST>`
notExpr :: Parser AST
notExpr = Not <$> (string "not" >> ast)

-- | Parses the litterals: `true|false` or `t|f` as their boolean representations
boolExpr :: Parser AST
boolExpr = Literal <$> (try true <|> false)
  where
    true = (try (string "true") <|> (string "t")) >> pure True
    false = (try (string "false") <|> string "f") >> pure False

andExpr :: Parser AST
andExpr = infixExpr (string "and") And

orExpr :: Parser AST
orExpr = infixExpr (string "or") Or

infixExpr :: Parser a -> (AST -> AST -> AST) ->  Parser AST
infixExpr op constr = betweenParens $ do
  l <- ast
  spaces
  op
  r <- ast
  pure $ constr l r


betweenParens :: Parser a -> Parser a
betweenParens p = do
  char '('
  a <- p
  char ')'
  pure a
