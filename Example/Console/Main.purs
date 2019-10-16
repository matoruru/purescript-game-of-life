module Example.Console.Main (main) where

import Prelude

import Effect (Effect, foreachE)
import Effect.Aff (Aff, Milliseconds(..), delay, forkAff, joinFiber, launchAff_)
import Effect.Class (liftEffect)
import Example.Console.Util (Readline, consoleClear, fieldInit, fieldSize, logTo, readline)
import Example.Console.Preference
import GameOfLife.Type (Diff, FieldSize, Pattern)
import GameOfLife.Util (diff, nextGen)

main :: Effect Unit
main = do
  fs <- fieldSize
  rl <- readline

  consoleClear
  fieldInit rl fs "□"

  launchAff_ $ loop rl fs (Milliseconds initialDelay) [] pattern

loop :: Readline -> FieldSize -> Milliseconds -> Pattern -> Pattern -> Aff Unit
loop rl fs t prev curr = do
  f1 <- forkAff $ pure $ nextGen fs curr
  f2 <- forkAff $ replace rl $ diff prev curr

  -- Wait all fibers finish
  next <- (\f _ -> f) <$> joinFiber f1 <*> joinFiber f2

  delay t *> loop rl fs (Milliseconds everyDelay) curr next

replace :: Readline -> Diff -> Aff Unit
replace rl d = do
  f1 <- forkAff $ liftEffect $ foreachE d.alive <<< flip logTo' $ "■"
  f2 <- forkAff $ liftEffect $ foreachE d.dead  <<< flip logTo' $ "□"

  -- Wait all fibers finish
  _ <- (\_ _ -> unit) <$> joinFiber f1 <*> joinFiber f2

  mempty

    where
      logTo' = logTo rl
