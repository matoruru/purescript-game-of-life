module Example.Console.Main2 (main) where

import Prelude

import Effect (Effect, foreachE)
import Effect.Aff (Aff, Milliseconds(..), delay, forkAff, joinFiber, launchAff_)
import Effect.Class (liftEffect)
import Example.Console.Preference (everyDelay, initialDelay, pattern)
import Example.Console.Util (Readline, consoleClear, fieldInit, fieldSize, logTo, readline)
import GameOfLife.Type (Diff', FieldSize, Pattern)
import GameOfLife.Util (diff', nextGen)

data Color = Black | Green | Red | Blue

main :: Effect Unit
main = do
  fs <- fieldSize
  rl <- readline

  consoleClear
  fieldInit rl fs $ color Black "□"

  launchAff_ $ loop rl fs (Milliseconds initialDelay) [] [] pattern

loop :: Readline -> FieldSize -> Milliseconds -> Pattern -> Pattern -> Pattern -> Aff Unit
loop rl fs t prev curr next = do
  f1 <- forkAff $ pure $ nextGen fs next
  f2 <- forkAff $ replace rl $ diff' prev curr next

  -- Wait all fibers finish
  next' <- joinFiber f1
  _     <- joinFiber f2

  delay t *> loop rl fs (Milliseconds everyDelay) curr next next'

replace :: Readline -> Diff' -> Aff Unit
replace rl d = do
  f1 <- forkAff $ liftEffect $ foreachE d.dead      <<< logTo' $ color Black "□"
  f2 <- forkAff $ liftEffect $ foreachE d.alive     <<< logTo' $ color Green "■"
  f3 <- forkAff $ liftEffect $ foreachE d.willDead  <<< logTo' $ color Red   "■"
  f4 <- forkAff $ liftEffect $ foreachE d.willAlive <<< logTo' $ color Blue  "□"

  -- Wait all fibers finish
  _ <- joinFiber f1
  _ <- joinFiber f2
  _ <- joinFiber f3
  _ <- joinFiber f4

  mempty

  where
    logTo' = flip $ logTo rl

color :: Color -> String -> String
color = (<>) <<< case _ of
  Black -> "\x1b[30m"
  Green -> "\x1b[32m"
  Red   -> "\x1b[31m"
  Blue  -> "\x1b[34m"
