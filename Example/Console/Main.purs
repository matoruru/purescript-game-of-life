module Example.Console.Main (main) where

import Prelude

import Data.Array (concat, (..))
import Data.Tuple (Tuple(..))
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Example.Console.Util (consoleClear, cursorTo, getColumns, getRows, log')
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Diff, Pattern, FieldSize)
import GameOfLife.Util (diff)

main :: Effect Unit
main = do
  fs <- fieldSize
  consoleClear
  fieldInit fs
  loop fs pattern

loop :: FieldSize -> Pattern -> Effect Unit
loop fs ps = do
  next <- nextGen fs ps # pure
  _    <- setTimeout 100 $ replace (diff ps next) *> loop fs next
  pure unit

pattern :: Pattern
pattern = concat
        [ P.glider
        ]

fieldSize :: Effect FieldSize
fieldSize = { w: _, h: _ } <$> getColumns <*> getRows

fieldInit :: FieldSize -> Effect Unit
fieldInit fs = foreachE (0 .. fs.w) \x -> foreachE (0 .. fs.h) \y -> cursorTo x y *> log' "□"

replace :: Diff -> Effect Unit
replace d = do
  foreachE d.alive $ with "■"
  foreachE d.dead  $ with "□"
    where
      with c (Tuple x y) = cursorTo x y *> log' c
