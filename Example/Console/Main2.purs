module Example.Console.Main2 (main) where

import Prelude

import Data.Array (concat)
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Example.Console.Util (Readline, consoleClear, fieldInit, fieldSize, logTo, readline)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Diff', FieldSize, Pattern)
import GameOfLife.Util (diff', move)

data Color = Black | Green | Red | Blue

main :: Effect Unit
main = do
  fs <- fieldSize
  rl <- readline
  consoleClear
  fieldInit rl fs $ color Black "□"
  replace rl (diff' [] [] pattern)
  _  <- setTimeout 1000 $ loop rl fs [] pattern
  pure unit

loop :: Readline -> FieldSize -> Pattern -> Pattern -> Effect Unit
loop rl fs prev curr = do
  next <- nextGen fs curr # pure
  _    <- setTimeout 90 $ replace rl (diff' prev curr next) *> loop rl fs curr next
  pure unit

pattern :: Pattern
pattern = concat
        [ P.gliderGun
        ]

replace :: Readline -> Diff' -> Effect Unit
replace rl d = do
  foreachE d.dead      <<< flip logTo' $ color Black "□"
  foreachE d.alive     <<< flip logTo' $ color Green "■"
  foreachE d.willDead  <<< flip logTo' $ color Red   "■"
  foreachE d.willAlive <<< flip logTo' $ color Blue  "□"
    where
      logTo' = logTo rl

color :: Color -> String -> String
color = (<>) <<< case _ of
  Black -> "\x1b[30m"
  Green -> "\x1b[32m"
  Red   -> "\x1b[31m"
  Blue  -> "\x1b[34m"
