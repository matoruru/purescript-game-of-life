module GameOfLife.Util
  ( consoleClear
  , showPattern
  ) where

import Prelude

import Data.Array (elem, sort, (..))
import Data.Tuple (Tuple(..), snd, swap)
import Effect (Effect, foreachE)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import GameOfLife.Type (Pattern, Width, Pos)

foreign import consoleClear :: Effect Unit

foreign import logNoNewlineImpl :: EffectFn1 String Unit

logNoNewline :: String -> Effect Unit
logNoNewline = runEffectFn1 logNoNewlineImpl

showPattern :: Width -> Pattern -> Effect Unit
showPattern w ps = do
  foreachE (map (getCell ps <> newLine w) <<< wholeBoard $ w) logNoNewline

getCell :: Pattern -> Pos -> String
getCell ps p = case swap p `elem` ps of
                 true  -> "■"
                 false -> "□"

newLine :: Width -> Pos -> String
newLine w p = case snd p == w - 1 of
                true  -> "\n"
                false -> ""

wholeBoard :: Width -> Pattern
wholeBoard w = do
  x <- 0 .. (w - 1)
  y <- 0 .. (w - 1)
  sort [ Tuple x y ]
