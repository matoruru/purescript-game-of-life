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
                true  -> logNoNewline $ "*" <> newLine p n
                false -> logNoNewline $ "_" <> newLine p n
            ) (wholeBoard n)
    where
      newLine p' n' = if (snd p' == (n' - 1)) then "\n" else ""

wholeBoard :: Width -> Array Pos
wholeBoard n = do
  i <- 0 .. (n - 1)
  j <- 0 .. (n - 1)
  sort [ Tuple i j ]
