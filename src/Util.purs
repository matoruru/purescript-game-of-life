module Util
  ( consoleClear
  , showPattern
  ) where

import Prelude

import Data.Array (elem, sort, (..))
import Data.Traversable (traverse_)
import Data.Tuple (Tuple(..), snd)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Type (Width, Pos)

foreign import consoleClear :: Effect Unit

foreign import logNoNewlineImpl :: EffectFn1 String Unit
logNoNewline :: String -> Effect Unit
logNoNewline = runEffectFn1 logNoNewlineImpl

showPattern :: Width -> Array Pos -> Effect Unit
showPattern n ps = do
  traverse_ ( \p -> case elem p ps of
                true  -> logNoNewline $ "*" <> newLine p
                false -> logNoNewline $ "_" <> newLine p
            ) $ wholeBoard n
    where
      newLine p
        | snd p == (n - 1) = "\n"
        | otherwise        = ""

wholeBoard :: Width -> Array Pos
wholeBoard n = do
  x <- 0 .. (n - 1)
  y <- 0 .. (n - 1)
  sort [ Tuple x y ]
