module Example.Console.Util
  ( consoleClear
  , cursorTo
  , getColumns
  , getRows
  , logNoNewline
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)

foreign import consoleClear :: Effect Unit

foreign import cursorToImpl :: EffectFn2 Int Int Unit

cursorTo :: Int -> Int -> Effect Unit
cursorTo = runEffectFn2 cursorToImpl

foreign import logNoNewlineImpl :: EffectFn1 String Unit

logNoNewline :: String -> Effect Unit
logNoNewline = runEffectFn1 logNoNewlineImpl

foreign import getRows :: Effect Int

foreign import getColumns :: Effect Int
