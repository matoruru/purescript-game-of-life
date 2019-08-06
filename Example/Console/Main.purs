module Example.Console.Main (main) where

import Prelude

import Data.Array (concat, (..))
import Data.Tuple (Tuple(..))
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Example.Console.Util (consoleClear, getColumns, getRows, logTo)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Diff, FieldSize, Pattern)
import GameOfLife.Util (diff, move)

main :: Effect Unit
main = do
  fs <- fieldSize
  consoleClear
  fieldInit fs "□"
  replace (diff [] pattern)
  _  <- setTimeout 1000 $ loop fs pattern
  pure unit

loop :: FieldSize -> Pattern -> Effect Unit
loop fs curr = do
  next <- nextGen fs curr # pure
  _    <- setTimeout 30 $ replace (diff curr next) *> loop fs next
  pure unit

pattern :: Pattern
pattern = concat
        [ move 50 50 P.acorn
        ]

replace :: Diff -> Effect Unit
replace d = do
  foreachE d.alive <<< flip logTo $ "■"
  foreachE d.dead  <<< flip logTo $ "□"
