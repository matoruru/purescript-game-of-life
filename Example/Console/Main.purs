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
  fieldInit fs
  loop fs pattern

loop :: FieldSize -> Pattern -> Effect Unit
loop fs ps = do
  next <- nextGen fs ps # pure
  _    <- setTimeout 50 $ replace (diff ps next) *> loop fs next
  pure unit

pattern :: Pattern
pattern = concat
        [ move 50 50 P.acorn
        ]

fieldSize :: Effect FieldSize
fieldSize = { w: _, h: _ } <$> getColumns <*> getRows

fieldInit :: FieldSize -> Effect Unit
fieldInit fs = foreachE (0 .. fs.w) \x -> foreachE (0 .. fs.h) \y -> logTo (Tuple x y) "□"

replace :: Diff -> Effect Unit
replace d = do
  foreachE d.alive <<< flip logTo $ "■"
  foreachE d.dead  <<< flip logTo $ "□"
