module Example.Console.Main (main) where

import Prelude

import Data.Array (concat)
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Example.Console.Util (Readline, consoleClear, fieldInit, fieldSize, logTo, readline)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Diff, FieldSize, Pattern)
import GameOfLife.Util (diff)

main :: Effect Unit
main = do
  fs <- fieldSize
  rl <- readline
  consoleClear
  fieldInit rl fs "□"
  replace rl (diff [] pattern)
  _  <- setTimeout 1000 $ loop rl fs pattern
  pure unit

loop :: Readline -> FieldSize -> Pattern -> Effect Unit
loop rl fs curr = do
  next <- nextGen fs curr # pure
  _    <- setTimeout 30 $ replace rl (diff curr next) *> loop rl fs next
  pure unit

pattern :: Pattern
pattern = concat
        [ P.gliderGun
        ]

replace :: Readline -> Diff -> Effect Unit
replace rl d = do
  foreachE d.alive <<< flip logTo' $ "■"
  foreachE d.dead  <<< flip logTo' $ "□"
    where
      logTo' = logTo rl
