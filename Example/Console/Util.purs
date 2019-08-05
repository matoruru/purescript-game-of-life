module Example.Console.Util
  ( consoleClear
  , cursorTo
  , getColumns
  , getRows
  , logTo
  ) where

import Prelude

import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import GameOfLife.Type (Pos)

foreign import consoleClear :: Effect Unit

foreign import cursorToImpl :: EffectFn2 Int Int Unit

cursorTo :: Int -> Int -> Effect Unit
cursorTo = runEffectFn2 cursorToImpl

foreign import logImpl :: EffectFn1 String Unit

log' :: String -> Effect Unit
log' = runEffectFn1 logImpl

logTo :: Pos -> String -> Effect Unit
logTo (Tuple x y) c = cursorTo x y *> log' c

foreign import getRows :: Effect Int

foreign import getColumns :: Effect Int
