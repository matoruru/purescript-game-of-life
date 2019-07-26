module GameOfLife.Util
  ( consoleClear
  , showPattern
  , move
  ) where

import Prelude

import Data.Array (elem, sort, (..))
import Data.Tuple (Tuple(..), snd, swap)
import Effect (Effect, foreachE)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import GameOfLife.Type (Width, Pattern)

foreign import consoleClear :: Effect Unit

foreign import logNoNewlineImpl :: EffectFn1 String Unit

logNoNewline :: String -> Effect Unit
logNoNewline = runEffectFn1 logNoNewlineImpl

showPattern :: Width -> Pattern -> Effect Unit
showPattern w ps = do
  foreachE ( map ( \p ->    if swap p `elem` ps then "■"  else "□"
                         <> if snd p == w - 1   then "\n" else ""
                 ) <<< wholeBoard $ w
           ) logNoNewline

wholeBoard :: Width -> Pattern
wholeBoard w = do
  x <- 0 .. (w - 1)
  y <- 0 .. (w - 1)
  sort [ Tuple x y ]

move :: Int -> Int -> Pattern -> Pattern
move x y = map (_ + Tuple x y)
