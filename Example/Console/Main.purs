module Example.Console.Main (main) where

import Prelude

import Data.Array (concat)
import Data.Tuple (Tuple(..))
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Example.Console.Util (consoleClear, cursorTo, getColumns, getRows, logNoNewline)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen, wrap)
import GameOfLife.Type (Diff, Pattern, FieldSize)
import GameOfLife.Util (diff)

main :: Effect Unit
main = do
  fs   <- fieldSize
  ps'  <- pure $ map (wrap fs) pattern
  consoleClear
  fieldInit fs
  loop fs pattern

loop :: FieldSize -> Pattern -> Effect Unit
loop fs ps = do
  next  <- pure $ nextGen fs ps
  _     <- setTimeout 100 $ replace (diff ps next) *> loop fs next
  pure unit

pattern :: Pattern
pattern = concat
        [ P.glider
        ]

fieldSize :: Effect FieldSize
fieldSize = do
  w <- getColumns
  h <- getRows
  pure { w: w, h: h - 1 }

fieldInit :: FieldSize -> Effect Unit
fieldInit fs = pure unit

replace :: Diff -> Effect Unit
replace d = do
  foreachE d.alive $ with "■"
  foreachE d.dead  $ with "□"
    where
      with c (Tuple x y) = cursorTo x y *> logNoNewline c
