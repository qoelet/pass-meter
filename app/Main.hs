module Main where

import           Control.Monad (forever)
import           Data.Text (pack)
import           Meter

main :: IO ()
main = do
  meter' <- meter <$> getDict "data/words.txt"
  forever $ do
    putStrLn "Enter a password (or Ctrl+C to quit):"
    (meter' . pack) <$> getLine >>= print
    putStrLn ""
