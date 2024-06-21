import System.IO
import System.Console.Haskeline
import Control.Monad.IO.Class (liftIO)
import Data.List (isInfixOf)
import Data.Char (toLower)
import System.Random (randomRIO)
import System.Console.ANSI (clearScreen)

data Command = Command
  {
    name :: String,
    description :: String,
    example :: String
  } deriving (Show)

bold = "\ESC[1m\STX"
purple = "\ESC[35m\STX"
lightPurple = "\ESC[1;35m\STX"
blue = "\ESC[34m\STX"
brightBlue = "\ESC[1;34m\STX"
reset = "\ESC[0m\STX"

printCommand :: Command -> IO ()
printCommand (Command cmd desc name ) = do
    putStrLn $ lightPurple ++ bold ++ "Command: "  ++ reset ++ lightPurple ++ cmd ++ reset
    putStrLn $ lightPurple ++ bold ++ "Description: " ++ reset ++ lightPurple ++ desc ++ reset 
    putStrLn $ brightBlue ++  bold ++ "Example: "  ++ reset ++ brightBlue ++ name ++ reset
    putStrLn $ replicate 80 '-' ++ "\n"

randomListItem :: [a] -> IO a
randomListItem list = do
    index <- randomRIO (0, length list - 1)
    return (list !! index)

loop :: [Command] -> InputT IO ()
loop commands = do
  outputStr $ blue ++ "Enter a command or description to search (q to quit): " ++ reset
  keyword <- getInputLine ""
  case keyword of
    Nothing -> return ()
    Just "q" -> do
      humor <- liftIO $ randomListItem haskellHumor
      outputStrLn $ "See ya later, " ++ humor
    Just keyword -> do
      let results = fuzzySearch keyword commands
      outputStrLn "\n"
      mapM_ (liftIO . printCommand) results
      loop commands

haskellHumor :: [String]
haskellHumor = 
    [
        "Monadic Wizard",
        "Type Juggler",
        "Lambda Wrangler",  
        "List Ninja",
        "Pattern Matcher",
        "Lazy Evaluator",
        "Lambda Luminary",
        "Pattern-Matching Ninja",
        "Combinator Connoisseur",
        "Point-Free Purist"
    ]

commands :: [Command]
commands =
    [
    Command "import" "Import a module" "import Data.List",
    Command "let" "Define a local variable" "let x = 5",
    Command "in" "Used in let expressions to specify the scope of the variables" "let x = 5 in x + 3",
    Command "where" "Used to define local bindings at the end of a function definition" "f x = y + z where y = x * 2; z = x + 3",
    Command "data" "Define a new data type" "data Bool = True | False",
    Command "type" "Define a type synonym" "type String = [Char]",
    Command "newtype" "Define a new data type with a single constructor" "newtype MyInt = MyInt Int",
    Command "deriving" "Automatically derive instances for a data type" "data Bool = True | False deriving (Eq, Show)",
    Command "instance" "Define an instance of a type class" "instance Eq Bool where (==) True True = True; (==) False False = True; (==) _ _ = False",
    Command "class" "Define a type class" "class Eq a where (==) :: a -> a -> Bool",
    Command "do" "Begin a block of statements in a monad" "do x <- action1; y <- action2; return (x + y)",
    Command "return" "Wrap a value in a monad" "return 5",
    Command "if" "Conditional expression" "if x > 5 then 'big' else 'small'",
    Command "then" "Used in if expressions" "if x > 5 then 'big' else 'small'",
    Command "else" "Used in if expressions" "if x > 5 then 'big' else 'small'",
    Command "case" "Pattern matching expression" "case x of 1 -> 'one'; 2 -> 'two'; _ -> 'other'",
    Command "of" "Used in case expressions" "case x of 1 -> 'one'; 2 -> 'two'; _ -> 'other'",
    Command "Just" "Wraps a value in a Maybe type, representing a present value" "Just 5 -- output  Just 5",
    Command "lambda" "Anonymous function" "\\x -> x + 1",
    Command "map" "Apply a function to each element of a list" "map (+1) [1, 2, 3] -- output  [2, 3, 4]",
    Command "filter" "Filter a list based on a predicate" "filter (> 2) [1, 2, 3, 4] -- output  [3, 4]",
    Command "foldl" "Left fold of a list" "foldl (+) 0 [1, 2, 3] -- output  6",
    Command "foldr" "Right fold of a list" "foldr (+) 0 [1, 2, 3] -- output  6",
    Command "++" "Concatenate two lists" "[1, 2] ++ [3, 4] -- output  [1, 2, 3, 4]",
    Command ":" "Cons operator, adds an element to the front of a list" "1 : [2, 3, 4] -- output  [1, 2, 3, 4]",
    Command "!!" "Index into a list" "[1, 2, 3] !! 1 -- output  2",
    Command "head" "Get the first element of a list" "head [1, 2, 3] -- output  1",
    Command "tail" "Get all elements of a list except the first" "tail [1, 2, 3] -- output  [2, 3]",
    Command "length" "Get the length of a list" "length [1, 2, 3] -- output  3",
    Command "null" "Check if a list is empty" "null [] -- output  True",
    Command "elem" "Check if an element is in a list" "elem 2 [1, 2, 3] -- output  True",
    Command "notElem" "Check if an element is not in a list" "notElem 4 [1, 2, 3] -- output  True",
    Command "reverse" "Reverse a list" "reverse [1, 2, 3] -- output  [3, 2, 1]",
    Command "sum" "Sum the elements of a list" "sum [1, 2, 3] -- output  6",
    Command "product" "Multiply the elements of a list" "product [1, 2, 3] -- output  6",
    Command "maximum" "Get the maximum element of a list" "maximum [1, 2, 3] -- output  3",
    Command "minimum" "Get the minimum element of a list" "minimum [1, 2, 3] -- output  1",
    Command "zip" "Combine two lists into a list of pairs" "zip [1, 2, 3] ['a', 'b', 'c'] -- output  [(1, 'a'), (2, 'b'), (3, 'c')]",
    Command "zipWith" "Combine two lists element-wise with a function" "zipWith (+) [1, 2, 3] [4, 5, 6] -- output  [5, 7, 9]",
    Command "cycle" "Create an infinite list by repeating a list" "take 10 (cycle [1, 2, 3]) -- output  [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]",
    Command "take" "Get the first n elements of a list" "take 3 [1, 2, 3, 4, 5] -- output  [1, 2, 3]",
    Command "drop" "Remove the first n elements of a list" "drop 3 [1, 2, 3, 4, 5] -- output  [4, 5]",
    Command "splitAt" "Split a list at a specific index" "splitAt 3 [1, 2, 3, 4, 5] -- output  ([1, 2, 3], [4, 5])",
    Command "lines" "Split a string into lines" "lines 'Hello\nWorld' -- output  ['Hello', 'World']",
    Command "words" "Split a string into words" "words 'Hello World' -- output  ['Hello', 'World']",
    Command "unlines" "Join a list of strings into a single string with newlines" "unlines ['Hello', 'World'] -- output  'Hello\nWorld'",
    Command "unwords" "Join a list of strings into a single string with spaces" "unwords ['Hello', 'World'] -- output  'Hello World'",
    Command "read" "Parse a string into a value of a specified type" "read '5' :: Int -- output  5",
    Command "show" "Convert a value into a string" "show 5 -- output  '5'",
    Command ".." "Create a list with a range of numbers" "[1..5] -- output  [1, 2, 3, 4, 5]",
    Command "guard" "A function used in list comprehensions and monads to filter results" "[x | x <- [1..10], guard (x `mod` 2 == 0), return x] -- output  [2, 4, 6, 8, 10]",
    Command "forever" "A function that repeats an action indefinitely in a monad" "forever (putStrLn 'Hello')",
    Command "when" "A function that conditionally executes an action in a monad" "when (x > 5) (putStrLn 'Big')",
    Command "forM_" "A function that maps over a list and executes actions in a monad, discarding the results" "forM_ [1..5] print",
    Command "mapM_" "A function that maps over a list and executes actions in a monad, discarding the results" "mapM_ print [1..5]",
    Command "IO" "The IO monad, used for performing input and output" "getLine :: IO String",
    Command "Maybe" "The Maybe type, used for optional values" "Just 5 :: Maybe Int",
    Command "Either" "The Either type, used for values that can be one of two types" "Left 'error' :: Either String Int",
    Command ">>=" "The bind operator for monads" "Just 5 >>= \\x -> return (x + 1) -- output  Just 6",
    Command ">>" "The sequence operator for monads" "putStrLn 'Hello' >> putStrLn 'World'"
    ]

toLowerCase :: String -> String
toLowerCase = map toLower

fuzzySearch :: String -> [Command] -> [Command]
fuzzySearch keyword = 
    filter (\cmd -> 
        let lowerKeyword = toLowerCase keyword
            lowerName = toLowerCase (name cmd)
            lowerDescription = toLowerCase (description cmd)
        in lowerKeyword `isInfixOf` lowerName || lowerKeyword `isInfixOf` lowerDescription)

main :: IO ()
main = do
  putStrLn $ replicate 2 '\n'
  putStrLn $ purple ++ (replicate 80 '*')
  putStrLn $ replicate 20 '*' ++ " Welcome to the Haskell Cheatsheet App! " ++ replicate 20 '*'
  putStrLn $ replicate 80 '*' ++ "\n" ++ reset
  repl commands

repl :: [Command] -> IO ()
repl cmds = 
    runInputT defaultSettings $ loop cmds
  where
    loop :: [Command] -> InputT IO ()
    loop commands = do
      outputStr $ blue ++ "Enter a command or description to search (q to quit): " ++ reset
      keyword <- getInputLine ""
      case keyword of
        Nothing -> return ()
        Just "q" -> do
          humor <- liftIO $ randomListItem haskellHumor
          outputStrLn $ "See ya later, " ++ humor
        Just keyword -> do
          let results = fuzzySearch keyword commands
          liftIO clearScreen
          outputStrLn "\n"
          mapM_ (liftIO . printCommand) results
          loop commands
