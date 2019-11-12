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
import GameOfLife.Type (Pos, FieldSize)

data Readline

foreign import readline :: Effect Readline

foreign import consoleClear :: Effect Unit

foreign import cursorTo :: Readline -> Int -> Int -> Effect Unit

foreign import logImpl :: String -> Effect Unit

logTo :: Readline -> Pos -> String -> Effect Unit
logTo rl (Tuple x y) c = cursorTo rl x y *> logImpl c

foreign import getRows :: Effect Int

foreign import getColumns :: Effect Int

fieldSize :: Effect FieldSize
fieldSize = { w: _, h: _ } <$> getColumns <*> getRows

fieldInit :: Readline -> FieldSize -> String -> Effect Unit
fieldInit rl fs s = foreachE (0 .. fs.w) \x -> foreachE (0 .. fs.h) \y -> logTo rl (Tuple x y) s
