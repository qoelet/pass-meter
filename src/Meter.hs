module Meter where

import           Data.Maybe (fromJust, isJust)
import qualified Data.Set as Set
import           Data.Text (Text)
import qualified Data.Text as T
import           Safe (readMay)
import           Text.AhoCorasick

data Strength
  = Weak
  | Strong
  deriving (Eq, Show)

data Hint
  = AllInteger
  | TooShort
  | NoMixedCase
  | Repetitive
  | CommonWords
  | Breached
  deriving (Eq, Show)

data Meter = Meter Strength (Maybe Hint)
  deriving (Eq, Show)

acMatch :: Text -> [String] -> Int -> Bool
acMatch s dict x
  | length res >= x = True
  | otherwise = False
  where
    s' = T.unpack . T.toLower $ s
    dict' = filter (\p -> length p >= 4) dict
    simpleSM = makeSimpleStateMachine dict'
    res = findAll simpleSM s'

repCheck :: Text -> Bool
repCheck s
  | fromIntegral (length sParts) / fromIntegral (length s') <= 0.5 = True
  | otherwise = False
  where
    s' = T.unpack s
    sParts = Set.toList . Set.fromList $ s'

getDict :: FilePath -> IO [String]
getDict x = map (takeWhile (/= '\r')) . lines <$> readFile x

meter :: [String] -> Text -> Meter
meter dict s
  | isJust (readMay (T.unpack s) :: Maybe Integer)
      && (show (fromJust (readMay (T.unpack s) :: Maybe Integer)) == T.unpack s)
      = Meter Weak (Just AllInteger)
  | T.length s <= 10 = Meter Weak (Just TooShort)
  | T.toUpper s == s || T.toLower s == s = Meter Weak (Just NoMixedCase)
  | repCheck s = Meter Weak (Just Repetitive)
  | acMatch s dict 5 = Meter Weak (Just CommonWords)
  | otherwise = Meter Strong Nothing
