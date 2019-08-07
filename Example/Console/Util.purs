module Example.Console.Util
  ( Readline
  , readline
  , consoleClear
  , cursorTo
  , fieldInit
  , fieldSize
  , getColumns
  , getRows
  , logTo
  ) where

import Prelude

import Data.Array ((..))
import Data.Tuple (Tuple(..))
import Effect (Effect, foreachE)
import Effect.Uncurried (EffectFn1, EffectFn3, runEffectFn1, runEffectFn3)
import GameOfLife.Type (Pos, FieldSize)

data Readline

foreign import readline :: Effect Readline

foreign import consoleClear :: Effect Unit

foreign import cursorToImpl :: EffectFn3 Readline Int Int Unit

cursorTo :: Readline -> Int -> Int -> Effect Unit
cursorTo = runEffectFn3 cursorToImpl

foreign import logImpl :: EffectFn1 String Unit

log' :: String -> Effect Unit
log' = runEffectFn1 logImpl

logTo :: Readline -> Pos -> String -> Effect Unit
logTo rl (Tuple x y) c = cursorTo rl x y *> log' c

foreign import getRows :: Effect Int

foreign import getColumns :: Effect Int

fieldSize :: Effect FieldSize
fieldSize = { w: _, h: _ } <$> getColumns <*> getRows

fieldInit :: Readline -> FieldSize -> String -> Effect Unit
fieldInit rl fs s = foreachE (0 .. fs.w) \x -> foreachE (0 .. fs.h) \y -> logTo rl (Tuple x y) s
