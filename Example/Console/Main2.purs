module Example.Console.Main2 (main) where

import Prelude

import Data.Array (concat)
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Example.Console.Util (consoleClear, fieldInit, fieldSize, logTo)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Diff', FieldSize, Pattern)
import GameOfLife.Util (diff')

data Color = Black | Green | Red | Blue

main :: Effect Unit
main = do
  fs <- fieldSize
  consoleClear
  fieldInit fs $ color Black "□"
  replace (diff' [] [] pattern)
  _  <- setTimeout 1000 $ loop fs [] pattern
  pure unit

loop :: FieldSize -> Pattern -> Pattern -> Effect Unit
loop fs prev curr = do
  next <- nextGen fs curr # pure
  _    <- setTimeout 30 $ replace (diff' prev curr next) *> loop fs curr next
  pure unit

pattern :: Pattern
pattern = concat
        [ P.gliderGun
        ]

replace :: Diff' -> Effect Unit
replace d = do
  foreachE d.dead      <<< flip logTo $ color Black "□"
  foreachE d.alive     <<< flip logTo $ color Green "■"
  foreachE d.willDead  <<< flip logTo $ color Red   "■"
  foreachE d.willAlive <<< flip logTo $ color Blue  "□"

color :: Color -> String -> String
color = (<>) <<< case _ of
  Black -> "\x1b[30m"
  Green -> "\x1b[32m"
  Red   -> "\x1b[31m"
  Blue  -> "\x1b[34m"
